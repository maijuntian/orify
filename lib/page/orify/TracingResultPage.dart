import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/model/tracing_result_entity.dart';
import 'package:gsy_github_app_flutter/common/net/address.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';
import 'package:gsy_github_app_flutter/widget/result_buy.dart';
import 'package:gsy_github_app_flutter/widget/result_item1.dart';
import 'package:gsy_github_app_flutter/widget/result_item2.dart';
import 'package:gsy_github_app_flutter/widget/result_map.dart';
import 'package:gsy_github_app_flutter/widget/result_no_login.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * Created by mai on 2019-12-31.
 */
class TracingResultPage extends StatefulWidget {
  TracingResultEntity entity;
  int code;

  @override
  _TracingResultPageState createState() => _TracingResultPageState();

  TracingResultPage(this.entity, this.code);
}

class _TracingResultPageState extends BaseTitlePage<TracingResultPage> {
  Widget result(MUserEntity user) {
    if(user == null || user.uuid == null){
      return Container();
    }

    widget.entity.points ??= "";
    String content = "";
    switch (widget.code) {
      case 200:
        content = CommonUtils.getLocale(context).anti_fake_tip3 +
            widget.entity.points +
            CommonUtils.getLocale(context).anti_fake_tip3_end;
        break;
      default:
        content = CommonUtils.getLocale(context).anti_fake_tip33;
        break;
    }

    return ResultItem1(
      widget.code == 200
          ? GSYICons.DEFAULT_IMAGE_PATH + "nfc_tag_success.png"
          : GSYICons.DEFAULT_IMAGE_PATH + "nfc_tag_fail.png",
      widget.entity.code,
      content,
      CommonUtils.getLocale(context).Feedback,
      onPressed: () {
        MNavigatorUtils.showFeedBackDialog(context, widget.entity.requestCode);
      },
    );
  }

  Widget product() {
    return ResultItem1(
      widget.entity.productIcon,
      widget.entity.productName,
      widget.entity.productDesc,
      CommonUtils.getLocale(context).Find_out_more,
      onPressed: () {
        MNavigatorUtils.showAboutDialog(context, widget.entity.productIcon,
            widget.entity.productName, widget.entity.productDesc);
      },
    );
  }

  Widget noLogin(){
    return result_no_login();
  }

  Widget manufacturer() {
    return ResultItem1(
      widget.entity.manufacturerIcon,
      widget.entity.manufacturerName,
      widget.entity.manufacturerDesc,
      CommonUtils.getLocale(context).Find_out_more,
      onPressed: () {
        MNavigatorUtils.showAboutDialog(context, widget.entity.manufacturerIcon,
            widget.entity.manufacturerName, widget.entity.manufacturerDesc);
      },
    );
  }

  List<Widget> traceItem() {
    List<Widget> widgets = <Widget>[];
    print(MAddress.host+"source/tracing/" + widget.entity.code + "/map");
    widgets.add(ResultMap(
      widget.entity.tracingResults.length>0?widget.entity.tracingResults[0].location:"",
      MAddress.host+"source/tracing/" + widget.entity.code + "/map",
    ));
//    widgets.add(CommonUtils.renderDivider());

    List<Widget> itemWidgets = <Widget>[];

    for (int i = 0; i < widget.entity.tracingResults.length; i++) {
      TracingResultTracingresult result = widget.entity.tracingResults[i];
      itemWidgets.add(new ResultItem2(
        result.name,
        result.data == null ? null : result.data[0].key,
        result.data == null ? null : result.data[0].value,
        result.time,
        result.location,
        result.identityIcon,
        result.imgUrl,
        isTop: i == 0,
        isBottom: i == widget.entity.tracingResults.length - 1,
      ));
    }

    widgets.add(GSYCardItem(
      radius: BorderRadius.only(
          bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
        child: Column(
          children: itemWidgets,
        ),
      ),
      margin: EdgeInsets.only(left: 16, right: 16),
    ));

    return widgets;
  }

  Widget buy() {
    widget.entity.suggestion.clear();

    if (widget.entity.suggestion == null ||
        widget.entity.suggestion.length == 0) {
      return Container();
    } else {
      List<Widget> itemWidgets = <Widget>[];

      widget.entity.suggestion.forEach((item) {
        itemWidgets.add(ResultBuy(
          item.platformIcon,
          item.remake,
          onPressed: () async {
            if (await canLaunch(item.url)) {
              await launch(item.url);
            } else {
              Fluttertoast.showToast(msg: 'Could not launch ${item.url}');
            }
          },
        ));
        itemWidgets.add(CommonUtils.renderDivider());
      });

      return GSYCardItem(
        radius: BorderRadius.all(Radius.circular(0)),
        child: Column(
          children: itemWidgets,
        ),
        margin: EdgeInsets.all(0),
      );
    }
  }

  @override
  Widget body(BuildContext context) {

    return new StoreBuilder<MaiState>(
        builder: (context, store) {
          MUserEntity user = store.state.userInfo;

          List<Widget> widgets = <Widget>[];
          widgets.add(Padding(
            padding: EdgeInsets.all(10),
          ));

          if(user == null|| user.uuid == null){
            widgets.add(noLogin());
          }

          for (int i = 0; i < widget.entity.traceResultConfig.length; i++) {
            TracingResultTraceresultconfig config =
            widget.entity.traceResultConfig[i];
            switch (config.key) {
              case "RESULT":
                widgets.add(result(user));
                break;
              case "PRODUCT":
                widgets.add(product());
                break;
              case "MANUFACTURER":
                widgets.add(manufacturer());
                break;
              case "TRACING_ITEM":
                widgets.addAll(traceItem());
                break;
            }
          }

          return Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          children: widgets,
                        ))),
                buy(),
              ],
            ),
          );
        }
    );
  }

  @override
  String title(BuildContext context) {
    return CommonUtils.getLocale(context).Tracing_Results;
  }
}
