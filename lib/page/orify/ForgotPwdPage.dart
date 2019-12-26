import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/dao/event_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/redux/user_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_input_pwd_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_input_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar3.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/gsy_nested_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/widget/state/base_person_state.dart';
import 'package:redux/redux.dart';

/**
 * 忘记密码页面
 * Created by mai
 * Date: 2018-07-16
 */
class ForgotPwdPage extends StatefulWidget {
  @override
  _ForgotPwdPageState createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  var _userName = "";
  var _password = "";
  var _confirmPassword = "";
  var _code = "";
  var countdown = 0;
  bool isSending = false;
  Timer _countdownTimer;

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();
  final TextEditingController confirmPwController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    userController.value = new TextEditingValue(text: "");
    pwController.value = new TextEditingValue(text: "");
    confirmPwController.value = new TextEditingValue(text: "");
    codeController.value = new TextEditingValue(text: "");
  }

  _sendCode(type) {
    if (isSending) return;
    isSending = true;
    if (type == "phone") {
      MUserDao.snsCode(_userName).then((res) {
        isSending = true;
        if (res.success) {
          if (res.data.code == 200) {
            _countDown();
          } else {
            Fluttertoast.showToast(msg: res.data.message);
          }
        }
      });
    } else {
      MUserDao.emailCode(_userName).then((res) {
        isSending = false;
        if (res.success) {
          if (res.data.code == 200) {
            _countDown();
          } else {
            Fluttertoast.showToast(msg: res.data.message);
          }
        }
      });
    }
  }

  _countDown() {
    countdown = 60;

    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (time) {
      setState(() {
        countdown--;
      });
      if (countdown <= 0) {
        _countdownTimer.cancel();
        _countdownTimer = null;
      }
    });
  }

  _reset(store) {
    CommonUtils.showLoadingDialog(context);
    MUserDao.resetPwd(_userName, _password, _code).then((res) {
      if (res.success) {
        if (res.data.code == 200) {
          _login(store);
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: res.data.message);
        }
      }
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
                          CommonUtils.getLocale(context).Reset_Password,
                          style: MConstant.largeTextWhite,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Text(
                          CommonUtils.getLocale(context).Reset_Password_Tip,
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
                            _userName = value;
                          },
                          controller: userController,
                          tapCallback: () {
                            userController.value = TextEditingValue(text: "");
                          },
                        ),
                        new MInputWidget(
                          hintText:
                              CommonUtils.getLocale(context).Verification_code,
                          rightText: countdown > 0
                              ? "${countdown}s"
                              : CommonUtils.getLocale(context).Send,
                          onChanged: (String value) {
                            _code = value;
                          },
                          controller: codeController,
                          tapCallback: () {
                            if (_userName == null || _userName.length == 0)
                              return;
                            if (countdown > 0) return;
                            _sendCode(
                                _userName.contains("@") ? "email" : "phone");
                          },
                        ),
                        new MPwdInputWidget(
                          hintText: CommonUtils.getLocale(context).Password,
                          onChanged: (String value) {
                            _password = value;
                          },
                          controller: pwController,
                        ),
                        new MPwdInputWidget(
                          hintText: CommonUtils.getLocale(context).Password,
                          onChanged: (String value) {
                            _confirmPassword = value;
                          },
                          controller: confirmPwController,
                        ),
                        Padding(padding: EdgeInsets.all(4.5)),
                        MIconText(
                          GSYICons.DEFAULT_IMAGE_PATH + "icon_message.png",
                          CommonUtils.getLocale(context).Passwords_Tip,
                          padding: 2,
                          size: 10,
                          style: TextStyle(
                              color: Color(0xff9B9B9B),
                              fontSize: MConstant.mminTextSize),
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        Padding(padding: EdgeInsets.all(15)),
                        GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: double.infinity,
                              child: Text(
                                  CommonUtils.getLocale(context).Continue,
                                  style: MConstant.middleTextGray),
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
                            if (_password == null || _password.length < 6) {
                              return;
                            }
                            if (_confirmPassword == null ||
                                _confirmPassword.length < 6) {
                              return;
                            }
                            if (_code == null || _code.length == 0) {
                              return;
                            }

                            if (_confirmPassword != _password) {
                              Fluttertoast.showToast(msg: CommonUtils.getLocale(context).Password_does_not_match);
                            }

                            CommonUtils.showLoadingDialog(context);
                            this._reset(store);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(55),
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
