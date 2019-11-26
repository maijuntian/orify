import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';

/**
 * title 控件
 * Created by mai
 * on 2018/7/24.
 */
class MImageTitleBarCommon extends StatelessWidget {
  final String backIcon;

  final String iconData;

  final double size;

  MImageTitleBarCommon(
      {this.backIcon = GSYICons.DEFAULT_IMAGE_PATH + "top_icon_back1.png",
      this.iconData = GSYICons.DEFAULT_IMAGE_PATH + "logo.png",
      this.size = 50});

  @override
  Widget build(BuildContext context) {
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
        new Expanded(
            child: new Padding(
          padding: EdgeInsets.only(right: 10),
          child: new Image.asset(
            this.iconData,
            height: 32,
            width: 103,
          ),
        )),
      ],
    );
  }
}
