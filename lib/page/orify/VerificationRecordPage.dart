import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/record_entity.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/RecordItem.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'BaseTitlePage.dart';

/**
 * Created by mai on 2019-11-27.
 */
class VerificationRecordPage extends StatefulWidget {
  @override
  _VerificationRecordPageState createState() => _VerificationRecordPageState();
}

class _VerificationRecordPageState
    extends BaseTitlePage<VerificationRecordPage> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<RecordList> data = <RecordList>[];
  int page = 0;

  Widget itemWidget() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 8, right: 8),
      itemBuilder: (c, i) =>
        RecordItem(
            data[i]
        )
      ,
      separatorBuilder: (context, index) {
        return Container(
          height: 5,
          color: Colors.transparent,
        );
      },
      itemCount: data.length,
    );
  }

  Widget body(BuildContext context) {


    return Expanded(
        child: SmartRefresher(
            enablePullUp: true,
            child: itemWidget(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowAlways,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: WaterDropHeader(),
            onRefresh: ()  {
              MUserDao.record(1).then((res){
                if(res.success){
                  if(res.data.code == 200){
                    RecordEntity entity = res.data.getObject();

                    this.data.clear();
                    if(entity.xList != null){
                      this.data.addAll(entity.xList);
                      page = entity.pageNum;
                    }
                    if (mounted) setState(() {});
                    _refreshController.refreshCompleted();

                  } else {
                    Fluttertoast.showToast(msg: res.data.message);
                  }
                }
              });
            },
            onLoading: () async {
              MUserDao.record(page+1).then((res){
                if(res.success){
                  if(res.data.code == 200){
                    RecordEntity entity = res.data.getObject();

                    if(entity.xList != null){
                      this.data.addAll(entity.xList);
                      page = entity.pageNum;
                    }
                    if (mounted) setState(() {});
                    _refreshController.loadComplete();

                  } else {
                    Fluttertoast.showToast(msg: res.data.message);
                  }
                }
              });
            },
            controller: _refreshController));
  }

  @override
  String title(BuildContext context) {
    return CommonUtils.getLocale(context).Verification_Record;
  }
}
