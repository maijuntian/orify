import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text_vertical.dart';

/**
 * 主页drawer
 * Created by mai
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_profile.png",
                                CommonUtils.getLocale(context).Profile,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                            new Padding(padding: EdgeInsets.all(25.0)),
                            GestureDetector(
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_verification_record.png",
                                CommonUtils.getLocale(context)
                                    .Verification_Record,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                            new Padding(padding: EdgeInsets.all(25.0)),
                            GestureDetector(
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH + "icon_ranks.png",
                                CommonUtils.getLocale(context)
                                    .Ranks_and_Interests,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              onTap: () {
                                MNavigatorUtils.goRankInterestsPage(context);
                              },
                            ),
                            new Padding(padding: EdgeInsets.all(25.0)),
                            GestureDetector(
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH +
                                    "icon_version.png",
                                CommonUtils.getLocale(context).Version,
                                style: MConstant.middleSubText,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 27, bottom: 27),
                      child: Row(
                        children: <Widget>[
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
                        ],
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
