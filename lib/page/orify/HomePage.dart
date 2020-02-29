import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/generated/i18n.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/model/version_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
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
import 'package:package_info/package_info.dart';

/**
 * 主页
 * Created by mai
 * Date: 2018-07-16
 */
class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String newUrl;
  String version;

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

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
      checkVersion();
    });
  }

  void checkVersion(){
    if(Platform.isIOS){
      MUserDao.iosVersion(MConstant.IOSAPPID).then((res){
        if(res.result){
          Map<String, dynamic> data = jsonDecode(res.data);
          if(data['resultCount'] > 0){
            String newVersion = data['results'][0]['version'];

            if(Comparable.compare(newVersion, version)>0){
              setState(() {
                newUrl = "yes_ios";
              });
            }
          }
        }
      });
    } else{
      MUserDao.version(version).then((res){
        if(res.success){
          if(res.data.code == 200){
            VersionEntity entity = res.data.getObject();
            if(!entity.latest){
              setState(() {
                newUrl=entity.androidUrl;
              });
            }
          }
        }
      });
    }
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
                      ""
              /*'Discover the Product\nSlogan Text'*/,
              style: MConstant.largeTextWhite,
              textAlign: TextAlign.center,
            ))),
            GestureDetector(
              child: Container(
                  height: 40,
                  width: 250,
                  child: MIconText(
                      GSYICons.DEFAULT_IMAGE_PATH + "icon_qr_code.png",
                      CommonUtils.getLocale(context).QR_Code),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(MColors.white), width: 1),
                    color: Color(MColors.white10),
                    borderRadius: BorderRadius.all(new Radius.circular(20)),
                  )),
              onTap: () {
                MNavigatorUtils.goScanQRCodePage(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            GestureDetector(
              child: Container(
                  height: 40,
                  width: 250,
                  child: MIconText(
                    GSYICons.DEFAULT_IMAGE_PATH + "icon_nfc_tag.png",
                    CommonUtils.getLocale(context).NFC_Tag,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(MColors.white), width: 1),
                    color: Color(MColors.white10),
                    borderRadius: BorderRadius.all(new Radius.circular(20)),
                  )),
              onTap: () {
                MNavigatorUtils.goNfcPage(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Text(
              CommonUtils.getLocale(context).Powered_Tip,
              style: MConstant.minTextWhite,
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
          ],
        ),
      );
    }

    return new StoreBuilder<MaiState>(builder: (context, store) {
      MUserEntity user = store.state.userInfo;

      ///增加返回按键监听
      return WillPopScope(
          onWillPop: () {
            return _dialogExitApp(context);
          },
          child: new Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                  GSYICons.DEFAULT_IMAGE_PATH + "main_bg.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Scaffold(
                backgroundColor: Color(MColors.trans),
                drawer: HomeDrawer(newUrl, version),
                appBar: new AppBar(
                  elevation: 0,
                  backgroundColor: Color(MColors.trans),
                  title: MImageTitleBar(
                    GSYICons.DEFAULT_IMAGE_PATH + "logo_orify.png",
                    iconData: user.uuid == null
                        ? GSYICons.DEFAULT_IMAGE_PATH + "top_icon_login_in.png"
                        : null,
                    needRightLocalIcon: user.uuid == null,
                    onPressed: () {
                      MNavigatorUtils.goLogin(context);
                    },
                  ),
                  titleSpacing: 2,
                ),
                body: _body(),
              ),
            ],
          ));
    });
  }
}
