import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/dao/event_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/redux/user_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_input_pwd_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_input_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar3.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/gsy_nested_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/widget/state/base_person_state.dart';
import 'package:redux/redux.dart';

/**
 * 登录页面
 * Created by mai
 * Date: 2018-07-16
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userName = "";
  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    _userName ??="";
    _password ??="";
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");

    setState(() {
    });
  }

  _login(store) {
    MUserDao.login(_userName, _password).then((res) {
      if (res.success) {
        if (res.data.code == 200) {
          return MUserDao.userInfo(store);
        } else {
          Fluttertoast.showToast(msg: res.data.message);
        }
      }
      return new Future.value(null);
    }).then((res) {
      Navigator.pop(context);
      if (res != null && res.success) {
        if (res.data.code == 200) {
          LocalStorage.save(Config.USER_NAME_KEY, _userName);
          LocalStorage.save(Config.PW_KEY, _password);
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: res.data.message);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<MaiState>(
      builder: (context, store) {
        return Scaffold(
          body: new Stack(children: <Widget>[
            Container(
                child: Image.asset(
              GSYICons.DEFAULT_IMAGE_PATH + "main_bg.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )),
            SafeArea(
              child: Column(
                children: <Widget>[
                  MImageTitleBarCommon(),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          CommonUtils.getLocale(context).User_Login,
                          style: MConstant.largeTextWhite,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          CommonUtils.getLocale(context)
                              .Please_enter_your_account_and_password,
                          style: MConstant.minTextWhite,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(color: Color(MColors.white)),
                    child: Column(
                      children: <Widget>[
                        new MInputWidget(
                          hintText: CommonUtils.getLocale(context)
                              .Mobile_number_or_email_address,
                          iconData: GSYICons.DEFAULT_IMAGE_PATH + "close.png",
                          onChanged: (String value) {
                            setState(() {
                              _userName = value;
                            });
                          },
                          controller: userController,
                          tapCallback: () {
                            userController.value = TextEditingValue(text: "");
                          },
                        ),
                        new MPwdInputWidget(
                          hintText: CommonUtils.getLocale(context).Password,
                          onChanged: (String value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          controller: pwController,
                        ),
                        Padding(padding: EdgeInsets.all(15)),
                        GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: double.infinity,
                              child: Text(CommonUtils.getLocale(context).Login,
                                  style: (_userName.length > 0 &&
                                          _password.length > 0)
                                      ? MConstant.middleTextBlack
                                      : MConstant.middleTextGray),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(MColors.grayTextColor),
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(20)),
                              )),
                          onTap: () {
                            if (_userName == null || _userName.length == 0) {
                              return;
                            }
                            if (_password == null || _password.length == 0) {
                              return;
                            }

                            CommonUtils.showLoadingDialog(context);
                            this._login(store);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.5),
                        ),
                        MIconText(
                          GSYICons.DEFAULT_IMAGE_PATH + "icon_message.png",
                          CommonUtils.getLocale(context).Login_Tip,
                          padding: 2,
                          size: 10,
                          style: TextStyle(
                              color: Color(0xff9B9B9B),
                              fontSize: MConstant.mminTextSize),
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        GestureDetector(
                          child: Container(
                            child: Text(
                              CommonUtils.getLocale(context).User_Agreement,
                              style: MConstant.mminTextBlue,
                            ),
                            padding: EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                          ),
                          onTap: () {
                            MNavigatorUtils.goWebViewPage(
                                context,
                                MAddress.getUserAgreement(),
                                CommonUtils.getLocale(context).User_Agreement2);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.5),
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                CommonUtils.getLocale(context).Forgot_Password,
                                style: TextStyle(
                                  color: Color(MColors.textColorBlack),
                                  fontSize: MConstant.minTextSize,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                MNavigatorUtils.goForgotPwdPage(context);
                              },
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Text(
                                  CommonUtils.getLocale(context)
                                      .Create_New_Account,
                                  style: TextStyle(
                                    color: Color(MColors.textColorBlack),
                                    fontSize: MConstant.minTextSize,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                onTap: () {
                                  MNavigatorUtils.goRegisterPage(context);
                                },
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(80),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
