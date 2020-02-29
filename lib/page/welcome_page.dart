import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';

/**
 * 欢迎页
 * Created by mai
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<MaiState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(milliseconds: 500), () {
      MUserDao.isLoginAsync().then((res) {
        if (res) {
          print("开始获取用户信息--->");
          return MUserDao.userInfo(store);
        } else {
          return null;
        }
      }).then((res) {
        if (res != null) {
          if (res.success && res.data.code == 200) {
            _home(store, res.data.getObject().region);
          } else {
            MUserDao.clearUserInfo(store);
            _region(store);
          }
        } else {
          _region(store);
        }
      });
    });
  }

  _region(store) {
    MUserDao.region().then((res) {
      print(res);
      if (res.success && res.data.code == 200) {
        print(res.data.getString());
        _home(store, res.data.getString());
      }
    });
  }

  _home(store, region) {
    CommonUtils.changeLocale(store, region);
    NavigatorUtils.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MaiState>(
      builder: (context, store) {
        return new Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                  GSYICons.DEFAULT_IMAGE_PATH + "main_bg.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Center(
                  child: Container(
                height: 175,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      GSYICons.DEFAULT_IMAGE_PATH + "logo_orify.png",
                      height: 83,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      CommonUtils.getLocale(context).welcome_tip,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
              Align(
                child: Container(
                  child: Text(
                    "www.orify.com.au",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 12,
                      color: Color(0xFFA1A2B6),
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 50),
                ),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        );
      },
    );
  }
}
