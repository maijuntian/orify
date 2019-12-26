import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/model/Event.dart';
import 'package:gsy_github_app_flutter/common/model/RepoCommit.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/event_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';
import 'package:gsy_github_app_flutter/widget/gsy_user_icon_widget.dart';
import 'package:gsy_github_app_flutter/common/model/Notification.dart' as Model;

/**
 * 事件Item
 * Created by mai
 * Date: 2018-07-16
 */
class ResultItem1 extends StatelessWidget {
  final String title;
  final int points;
  final VoidCallback onPressed;
  final bool succ;

  ResultItem1(
      this.succ,
    this.title,
    this.points, {
    this.onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {

    Widget icon =
    Image.asset(
      GSYICons.DEFAULT_IMAGE_PATH +( succ?"nfc_tag_fail.png":"nfc_tag_success.png"),
      fit: BoxFit.contain,
      width: 88,
      height: 88,
    );

    return new Container(
      child: new GSYCardItem(
        child: Padding(
          padding: EdgeInsets.only(left: 26, right: 26, top: 28, bottom: 30),
          child: Row(
            children: <Widget>[
              icon,
              Padding(
                padding: EdgeInsets.all(13),
              ),
              Column(
                children: <Widget>[
                  Text(
                    title,
                    style: MConstant.middleTextBlack,
                  ),
                ],
              )
            ],
          ),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 9, bottom: 9),
      ),
    );
  }
}
