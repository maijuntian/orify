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
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';

/**
 * 事件Item
 * Created by mai
 * Date: 2018-07-16
 */
class ResultItem2 extends StatelessWidget {
  final String name;
  final String key1;
  final String value;
  final String time;
  final String location;
  final String icon;
  final String img;
  final bool isTop;
  final bool isBottom;

  ResultItem2(this.name, this.key1, this.value, this.time, this.location,
      this.icon, this.img,
      {this.isTop = false, this.isBottom = false})
      : super();

  @override
  Widget build(BuildContext context) {
    Widget topLine = isTop
        ? Container()
        : Container(
            height: 24,
            width: 2,
            color: Color(0xffC5C5C5),
          );
    Widget bottomLine = isBottom
        ? Container()
        : Container(
            height: 110,
            width: 2,
            color: Color(0xffC5C5C5),
          );

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Center(
              child: topLine,
            ),
            Image.network(
              icon,
              height: 20,
              width: 20,
            ),
            Center(
              child: bottomLine,
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(8)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new ClipOval(
                  child: new FadeInImage.assetNetwork(
                    fadeInDuration: Duration(milliseconds: 300),
                    fit: BoxFit.fill,
                    image: img,
                    width: 56.0,
                    height: 56.0,
                    placeholder: GSYICons.DEFAULT_IMAGE_PATH + "logo_orify.png",
                  ),
                ),
                Padding(padding: EdgeInsets.all(6)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: MConstant.middleTextBlack,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          key1 == null ? "" : "${key1}: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff9B9B9B),
                          ),
                        ),
                        Text(
                          value == null ? "" : "${value}: ",
                          style: MConstant.minTextBlack,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(8)),
            MIconText(
              GSYICons.DEFAULT_IMAGE_PATH + "icon_time.png",
              time,
              size: 10,
              padding: 8,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff9B9B9B),
              ),
            ),
            MIconText(
              GSYICons.DEFAULT_IMAGE_PATH + "icon_address.png",
              location,
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
    );
  }
}
