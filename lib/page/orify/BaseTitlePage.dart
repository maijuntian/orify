import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar4.dart';

/**
 * Created by mai on 2019-11-27.
 */
abstract class BaseTitlePage<T extends StatefulWidget> extends State<T> {

  @protected
  Widget body(BuildContext context);

  @protected
  String title(BuildContext context);

  @protected
  Color backgroundColor() {
    return Color(0xFFEEEEEE);
  }

  @protected
  Widget getRight(){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            MTitleBarCommon(
              title(context),
              right: getRight(),
            ),
            Container(
              child: body(context),
            ),
          ],
        )));
  }
}
