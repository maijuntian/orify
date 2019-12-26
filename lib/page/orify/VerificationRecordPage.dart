import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
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
      RefreshController(initialRefresh: false);
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  Widget itemWidget() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 8, right: 8),
      itemBuilder: (c, i) =>
        Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                ],
              )
            ],
          ),
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

    /*return Container(
      child: Text("test"),
    );*/

    return Expanded(
        child: SmartRefresher(
            enablePullUp: true,
            child: itemWidget(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowAlways,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: WaterDropHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              if (data.length == 0) {
                for (int i = 0; i < 10; i++) {
                  data.add("Item $i");
                }
              }
              if (mounted) setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              if (mounted) setState(() {});
              _refreshController.loadFailed();
            },
            controller: _refreshController));
  }

  @override
  String title(BuildContext context) {
    return CommonUtils.getLocale(context).Verification_Record;
  }
}
