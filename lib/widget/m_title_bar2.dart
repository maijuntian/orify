import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

/**
 * title 控件
 * Created by mai
 * on 2018/7/24.
 */
class MImageTitleBar extends StatelessWidget {
  final String image;

  final String iconData;

  final VoidCallback onPressed;

  final bool needRightLocalIcon;

  final Widget rightWidget;

  MImageTitleBar(this.image,
      {this.iconData,
      this.onPressed,
      this.needRightLocalIcon = false,
      this.rightWidget});

  @override
  Widget build(BuildContext context) {
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? new IconButton(
              icon: Image.asset(this.iconData), onPressed: onPressed)
          : new Container(padding: EdgeInsets.only(left: 50),);
    }
    return Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Padding(
            padding: EdgeInsets.only(right: 10),
            child: new Image.asset(this.image, height: 32, width: 103,),
          )),
          widget,
        ],
      ),
    );
  }
}
