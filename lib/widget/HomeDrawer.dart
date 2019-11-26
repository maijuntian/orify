import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
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

          if (user.uuid == null) {
            return new Drawer(
                child: new Container(
              ///默认背景
              color: Color(MColors.white),
              child: new FlatButton(
                  onPressed: () {
                    MNavigatorUtils.goLogin(context);
                  },
                  child: new Text("登录")),
            ));
          } else {
            return new Drawer(
              ///侧边栏按钮Drawer
              child: new Container(
                ///默认背景
                color: Color(MColors.white),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      ///用户头像
                      new RawMaterialButton(
                          onPressed: () {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.all(0.0),
                          constraints: const BoxConstraints(
                              minWidth: 0.0, minHeight: 0.0),
                          child: new ClipOval(
                            child: new FadeInImage.assetNetwork(
                              fit: BoxFit.fitWidth,
                              image: user.icon,
                              width: 80.0,
                              height: 80.0,
                              placeholder: GSYICons.DEFAULT_USER_ICON,
                            ),
                          )),
                      new Padding(padding: EdgeInsets.all(5.0)),
                      new Text(
                        user.name,
                        style: MConstant.largeTextBlack,
                      ),
                      new Padding(padding: EdgeInsets.all(30.0)),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: MIconText(
                                  GSYICons.DEFAULT_USER_ICON,
                                  "Test1",
                                  style: MConstant.middleSubText,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                onTap: () {},
                              ),
                              new Padding(padding: EdgeInsets.all(10.0)),
                              GestureDetector(
                                child: MIconText(
                                  GSYICons.DEFAULT_USER_ICON,
                                  "Test2",
                                  style: MConstant.middleSubText,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                onTap: () {},
                              ),
                              new Padding(padding: EdgeInsets.all(10.0)),
                              GestureDetector(
                                child: MIconText(
                                  GSYICons.DEFAULT_USER_ICON,
                                  "Test3",
                                  style: MConstant.middleSubText,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                onTap: () {},
                              ),
                              new Padding(padding: EdgeInsets.all(10.0)),
                              GestureDetector(
                                child: MIconText(
                                  GSYICons.DEFAULT_USER_ICON,
                                  "Test4",
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
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                        children: <Widget>[
                          Expanded(
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
                          ),
                        ],
                      ),)

                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
