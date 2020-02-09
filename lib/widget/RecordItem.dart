import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/generated/i18n.dart';
import 'package:gsy_github_app_flutter/common/model/record_entity.dart';
import 'package:gsy_github_app_flutter/common/model/tracing_result_entity.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/result_item2.dart';
import 'package:gsy_github_app_flutter/widget/result_map.dart';

import 'gsy_card_item.dart';
import 'm_icon_text.dart';

/**
 * Created by mai on 2020-01-02.
 */
class RecordItem extends StatefulWidget {
  RecordList entity;

  bool isShowDetail = false;

  RecordItem(this.entity);

  @override
  _RecordItemState createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  List<Widget> recordTitle() {
    List<Widget> widgets = <Widget>[];
    widgets.add(Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new ClipOval(
              child: Image.network(
            widget.entity.manufacturerIcon,
            height: 26,
            width: 26,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          Text(
            widget.entity.manufacturerName,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            widget.entity.authStatus,
            style: TextStyle(
              color: Color(widget.entity.authStatus == "Success"
                  ? 0xFF00001B
                  : 0xFFFF2424),
              fontSize: 12,
            ),
          )
        ],
      ),
    ));
    widgets.add(CommonUtils.renderDivider());
    widgets.add(Padding(
      padding: EdgeInsets.only(
        left: 4,
        right: 10,
        top: 10,
        bottom: 18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            widget.entity.productIcon,
            height: 85,
            width: 85,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
              ),
              Text(
                widget.entity.productName,
                style: MConstant.middleTextBlack,
                maxLines: 1,
              ),
              Padding(
                padding: EdgeInsets.all(7),
              ),
              MIconText(
                GSYICons.DEFAULT_IMAGE_PATH + "icon_time.png",
                widget.entity.authTime,
                size: 10,
                padding: 8,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff9B9B9B),
                ),
              ),
            ],
          )
        ],
      ),
    ));
    if (widget.entity.tracingResults == null) {
      widgets.add(Padding(
        padding: EdgeInsets.all(8),
      ));
    } else {
      widgets.add(Image.asset(
        GSYICons.DEFAULT_IMAGE_PATH +
            (widget.isShowDetail ? "bt_arrow_up.png" : "bt_arrow_down.png"),
        height: 8,
        width: 15,
      ));
    }
    widgets.add(Padding(
      padding: EdgeInsets.all(2),
    ));
    return widgets;
  }

  List<Widget> recordContent() {
    List<Widget> widgets = <Widget>[];
    print(MAddress.host + widget.entity.authCode + "/map");
    widgets.add(ResultMap(
      widget.entity.tracingResults.length > 0
          ? widget.entity.tracingResults[0].location
          : "",
      MAddress.host + "source/tracing/" + widget.entity.authCode + "/map",
      margin: EdgeInsets.all(0),
      radius: 0,
    ));

    if (widget.entity.tracingResults != null) {
      List<Widget> itemWidgets = <Widget>[];

      for (int i = 0; i < widget.entity.tracingResults.length; i++) {
        RecordListTracingresult result = widget.entity.tracingResults[i];
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
        margin: EdgeInsets.only(left: 0, right: 0),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    widgets.add(GestureDetector(
      child: Column(
        children: recordTitle(),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.isShowDetail = !widget.isShowDetail;
        setState(() {});
      },
    ));
    if (widget.isShowDetail && widget.entity.tracingResults != null) {
      widgets.addAll(recordContent());
    }

    return new Container(
      child: new GSYCardItem(
        child: Column(
          children: widgets,
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
      ),
    );
  }
}
