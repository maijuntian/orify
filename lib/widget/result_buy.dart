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
class ResultBuy extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String icon;
  final String subTitle;

  ResultBuy(
    this.icon,
    this.subTitle, {
    this.onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 28, right: 28, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(28)),
            Image.asset(
              icon,
              height: 15,
              width: 100,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff586575),
              ),
            ),
            Image.asset(
              GSYICons.DEFAULT_IMAGE_PATH + "icon_arrow.png",
              width: 15,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
