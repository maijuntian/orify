import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

/**
 * title 控件
 * Created by mai
 * on 2018/7/24.
 */
class MTitleBar extends StatelessWidget {
  final String title;

  final String iconData;

  final VoidCallback onPressed;

  final bool needRightLocalIcon;

  final Widget rightWidget;

  MTitleBar(this.title,
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
          : new Container();
    }
    return Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Padding(
            padding: EdgeInsets.only(right: 10),
            child: new Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )),
          widget,
        ],
      ),
    );
  }
}
