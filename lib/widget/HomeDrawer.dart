import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text_vertical.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * 主页drawer
 * Created by mai
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {
  String newUrl;
  String version;

  HomeDrawer(this.newUrl, this.version);

  @override
  Widget build(BuildContext context) {
    Widget newWidget = (newUrl == null || newUrl.length == 0)
        ? Container()
        : Text(
            "New",
            style: TextStyle(
              color: Color(0xFFF26262),
              fontSize: 14,
            ),
          );

    return Material(
      child: new StoreBuilder<MaiState>(
        builder: (context, store) {
          MUserEntity user = store.state.userInfo;

          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              color: Color(MColors.white),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.all(10.0)),

                    ///用户头像
                    new RawMaterialButton(
                        onPressed: () {
                          if (user.uuid == null) {
                            //跳转登录
                            MNavigatorUtils.goLogin(context);
                          } else {
                            MNavigatorUtils.goUserInfoPage(context);
                          }
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0.0),
                        constraints:
                            const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                        child: new ClipOval(
                          child: new FadeInImage.assetNetwork(
                            fadeInDuration: Duration(milliseconds: 300),
                            fit: BoxFit.cover,
                            image: user.icon == null
                                ? GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_login_in.png"
                                : user.icon,
                            width: 60.0,
                            height: 60.0,
                            placeholder: GSYICons.DEFAULT_IMAGE_PATH +
                                "icon_login_in.png",
                          ),
                        )),
                    new Padding(padding: EdgeInsets.all(5.0)),
                    new Text(
                      user.name == null ? "" : user.name,
                      style: MConstant.largeTextBlack,
                    ),
                    new Padding(padding: EdgeInsets.all(30.0)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_profile.png",
                                CommonUtils.getLocale(context).Profile,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                                size: 25,
                              ),
                              onTap: () {
                                if (user.uuid == null) {
                                  //跳转登录
                                  MNavigatorUtils.goLogin(context);
                                } else {
                                  MNavigatorUtils.goUserInfoPage(context);
                                }
                              },
                            ),
                            new Padding(padding: EdgeInsets.all(20.0)),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_verification_record.png",
                                CommonUtils.getLocale(context)
                                    .Verification_Record,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                                size: 25,
                              ),
                              onTap: () {
                                if (user.uuid == null) {
                                  //跳转登录
                                  MNavigatorUtils.goLogin(context);
                                } else {
                                  MNavigatorUtils.goVerificationRecord(context);
                                }
                              },
                            ),
                            /* new Padding(padding: EdgeInsets.all(25.0)),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH + "icon_ranks.png",
                                CommonUtils.getLocale(context)
                                    .Ranks_and_Interests,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                                size: 25,
                              ),
                              onTap: () {
                                MNavigatorUtils.goRankInterestsPage(context);
                              },
                            ),*/
                            new Padding(padding: EdgeInsets.all(20.0)),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_user_agreement.png",
                                CommonUtils.getLocale(context).User_Agreement2,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                                size: 25,
                              ),
                              onTap: () {
                                MNavigatorUtils.goWebViewPage(
                                    context,
                                    MAddress.getUserAgreement(),
                                    CommonUtils.getLocale(context)
                                        .User_Agreement2);
                              },
                            ),
                            new Padding(padding: EdgeInsets.all(20.0)),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH + "icon_about.png",
                                CommonUtils.getLocale(context).About,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                                size: 25,
                              ),
                              onTap: () {
                                MNavigatorUtils.goWebViewPage(
                                    context,
                                    MAddress.getAbout(),
                                    CommonUtils.getLocale(context).About);
                              },
                            ),
                            new Padding(padding: EdgeInsets.all(20.0)),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  MIconText(
                                    GSYICons.DEFAULT_IMAGE_PATH +
                                        "icon_version.png",
                                    CommonUtils.getLocale(context).Version +
                                        "(" +
                                        version +
                                        ")",
                                    style: MConstant.middleSubText,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    size: 25,
                                  ),
                                  newWidget,
                                ],
                              ),
                              onTap: () async {
                                if (newUrl == null || newUrl.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: CommonUtils.getLocale(context)
                                          .versionTip);
                                } else {
                                  if (Platform.isIOS) {
                                    final url =
                                        "https://itunes.apple.com/cn/app/id"+MConstant.IOSAPPID; // id 后面的数字换成自己的应用 id 就行了
                                    if (await canLaunch(url)) {
                                      await launch(url, forceSafariVC: false);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  } else {
                                    if (await canLaunch(newUrl)) {
                                      await launch(newUrl, forceSafariVC: false);
                                    } else {
                                      throw 'Could not launch $newUrl';
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 27),
                      child: Center(
                        child:
                          GestureDetector(
                            child: MIconTextVertical(
                              GSYICons.DEFAULT_IMAGE_PATH +
                                  (user.uuid == null
                                      ? "icon_login_in.png"
                                      : "icon_logout.png"),
                              user.uuid == null
                                  ? CommonUtils.getLocale(context).Login_in
                                  : CommonUtils.getLocale(context).Logout,
                              style: MConstant.middleSubText,
                              padding: 3.5,
                              size: 35,
                            ),
                            onTap: () {
                              if (user.uuid == null) {
                                //跳转登录
                                MNavigatorUtils.goLogin(context);
                              } else {
                                //退出登录
                                MUserDao.clearUserInfo(store);
                              }
                            },
                          ),

                          /* Expanded(
                            child: GestureDetector(
                              child: MIconTextVertical(
                                GSYICons.DEFAULT_USER_ICON,
                                "Test1",
                                style: MConstant.middleSubText,
                              ),
                              onTap: () {},
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: MIconTextVertical(
                                GSYICons.DEFAULT_USER_ICON,
                                "Test2",
                                style: MConstant.middleSubText,
                              ),
                              onTap: () {},
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: MIconTextVertical(
                                GSYICons.DEFAULT_USER_ICON,
                                "Test3",
                                style: MConstant.middleSubText,
                              ),
                              onTap: () {},
                            ),
                            flex: 1,
                          ),*/
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
