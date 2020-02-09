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
  final String content;
  final String pressText;
  final GestureTapCallback onPressed;
  final String icon;

  ResultItem1(
    this.icon,
    this.title,
    this.content,
    this.pressText, {
    this.onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Widget icon = null;
    if(this.icon.contains("http")){
      icon = Image.network(this.icon, width: 80, height: 80, fit: BoxFit.contain,);
    } else {
      icon = Image.asset(
        this.icon,
        fit: BoxFit.contain,
        width: 80,
        height: 80,
      );
    }
    
    

    return new Container(
      child: new GSYCardItem(
        child: Padding(
          padding: EdgeInsets.only(left: 13, right: 13, top: 14, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              icon,
              Padding(
                padding: EdgeInsets.all(6.5),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: MConstant.middleTextBlack,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.5),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff9B9B9B),
                      ),
                      maxLines: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.5),
                    ),
                    GestureDetector(
                      child: Text(
                        pressText,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff00001B),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: onPressed,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 9, bottom: 9),
      ),
    );
  }
}
