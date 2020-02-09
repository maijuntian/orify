import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';

/**
 * title 控件
 * Created by mai
 * on 2018/7/24.
 */
class MTitleBarCommon extends StatelessWidget {
  final String backIcon;

  final String title;

  final double size;

  final TextStyle style;

  final Widget right;

  MTitleBarCommon(this.title,
      {this.backIcon = GSYICons.DEFAULT_IMAGE_PATH + "top_icon_back2.png",
      this.style = MConstant.normalTextBlack,
      this.size = 30,
      this.right});

  @override
  Widget build(BuildContext context) {
    Widget rightWgt = right == null
        ? Container()
        : Container(
            height: 50,
            margin: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: right,
            ),
          );

    return new Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            child: new Image(
              image: AssetImage(backIcon),
              width: size,
              height: size,
            ),
            padding: EdgeInsets.all(10),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          height: 50,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: style,
            ),
          ),
        ),
        rightWgt,
      ],
    );
  }
}
