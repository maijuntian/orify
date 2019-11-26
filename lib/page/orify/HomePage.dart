import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/dynamic_page.dart';
import 'package:gsy_github_app_flutter/page/my_page.dart';
import 'package:gsy_github_app_flutter/page/orify/UserPage.dart';
import 'package:gsy_github_app_flutter/page/trend_page.dart';
import 'package:gsy_github_app_flutter/widget/HomeDrawer.dart';
import 'package:gsy_github_app_flutter/widget/gsy_tabbar_widget.dart';
import 'package:gsy_github_app_flutter/widget/gsy_title_bar.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar2.dart';

/**
 * 主页
 * Created by mai
 * Date: 2018-07-16
 */
class HomePage extends StatelessWidget {
  static final String sName = "home";

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return new Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Center(
                    child: Text(
              'Discover the Product\nSlogan Text',
              style: MConstant.largeTextWhiteBold,
                      textAlign: TextAlign.center,

            ))),
            GestureDetector(
                  child: Container(
                      height: 40,
                      width: 200,
                      child: MIconText(GSYICons.DEFAULT_USER_ICON, "QR Code"),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(MColors.white), width: 1),
                        color: Color(MColors.white10),
                        borderRadius: BorderRadius.all(new Radius.circular(20)),
                      )),
              onTap: () {},
            ),
            Padding(padding: EdgeInsets.only(top: 15),),
            GestureDetector(
              child: Container(
                  height: 40,
                  width: 200,
                  child: MIconText(GSYICons.DEFAULT_USER_ICON, "NFC Tag"),
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Color(MColors.white), width: 1),
                    color: Color(MColors.white10),
                    borderRadius: BorderRadius.all(new Radius.circular(20)),
                  )),
              onTap: () {},
            ),
            Padding(padding: EdgeInsets.only(top: 30),),
            Text("Powered by Viverify Blockchain Technology", style: MConstant.smallTextWhite,),
            Padding(padding: EdgeInsets.only(top: 30),),
          ],
        ),
      );
    }

    ///增加返回按键监听
    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: new Stack(
          children: <Widget>[
            /*Container(
              child: Image.asset(
                "static/images/welcome.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),*/
            Scaffold(
              backgroundColor: Color(MColors.black),
              drawer: HomeDrawer(),
              appBar: new AppBar(
                elevation: 0,
                backgroundColor: Color(MColors.trans),
                title: MImageTitleBar(
                  GSYICons.DEFAULT_IMAGE_PATH+"logo.png",
                  iconData: GSYICons.DEFAULT_IMAGE_PATH+"top_icon_logout.png",
                  needRightLocalIcon: true,
                  onPressed: () {
                    NavigatorUtils.goSearchPage(context);
                  },
                ),
                titleSpacing: 2,
              ),
              body: _body(),
            ),
          ],
        ));
  }
}
