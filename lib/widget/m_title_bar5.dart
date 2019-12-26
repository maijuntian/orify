import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';

/**
 * title 控件
 * Created by mai
 * on 2018/7/24.
 */
class MRightTextTitleBarCommon extends StatelessWidget {
  final String backIcon;

  final String rightText;

  final double size;

  final GestureTapCallback onTap;

  MRightTextTitleBarCommon(
      {this.backIcon = GSYICons.DEFAULT_IMAGE_PATH + "top_icon_back1.png",
      this.rightText,
      this.size = 30,
      this.onTap});

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
        Container(
          height: 50,
          margin: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                rightText,
                style: MConstant.smallTextWhite,
              ),
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
