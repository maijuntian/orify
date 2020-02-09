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
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/m_user_redux.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/redux/user_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';
import 'package:gsy_github_app_flutter/widget/m_icon_text.dart';
import 'package:gsy_github_app_flutter/widget/m_input_pwd_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_input_widget.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar3.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/gsy_nested_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/widget/state/base_person_state.dart';
import 'package:redux/redux.dart';

/**
 * 完善信息页面
 * Created by mai
 * Date: 2018-07-16
 */
class UserMobilePage extends StatefulWidget {
  @override
  _UserMobilePageState createState() => _UserMobilePageState();
}

class _UserMobilePageState extends BaseTitlePage<UserMobilePage> {
  var _userName = "";
  var _code = "";
  var countdown = 0;
  bool isSending = false;
  Timer _countdownTimer;

  final TextEditingController userController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    userController.value = new TextEditingValue(text: "");
    codeController.value = new TextEditingValue(text: "");
  }

  _sendCode() {
    _countDown();
    MUserDao.snsCode(_userName).then((res) {
      if (res.success) {
        if (res.data.code == 200) {
        } else {
          Fluttertoast.showToast(msg: res.data.message);
        }
      }
    });
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

  @override
  Widget body(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    CommonUtils.getLocale(context).Cell,
                    style: MConstant.middleTextGray,
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    maxLines: 1,
                    style: MConstant.middleTextBlack,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //去掉输入框的下滑线
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: null,
                        disabledBorder: null),
                    onChanged: (String value) {
                      _userName = value;
                    },
                    controller: userController,
                  ),
                ),
              ],
            ),
          ),
          CommonUtils.renderDivider(),
          Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    CommonUtils.getLocale(context).Code,
                    style: MConstant.middleTextGray,
                  ),
                  flex: 1,
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            style: MConstant.middleTextBlack,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                //去掉输入框的下滑线
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: null,
                                disabledBorder: null),
                            onChanged: (String value) {
                              _code = value;
                            },
                            controller: codeController,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                              height: 30,
                              width: 70,
                              child: MIconText(
                                GSYICons.DEFAULT_IMAGE_PATH + "icon_send.png",
                                countdown > 0
                                    ? "${countdown}s"
                                    : CommonUtils.getLocale(context).Send,
                                size: 14,
                                padding: 4,
                                style: MConstant.minTextBlack,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff979797), width: 1),
                                color: Color(MColors.trans),
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(15)),
                              )),
                          onTap: () {
                            if (_userName == null || _userName.length == 0)
                              return;
                            if (countdown > 0) return;
                            _sendCode();
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  String title(BuildContext context) {
    // TODO: implement title
    return CommonUtils.getLocale(context).Mobile_Number;
  }

  @override
  Widget getRight() {
    return new StoreBuilder<MaiState>(builder: (context, store) {
      return new IconButton(
          iconSize: 30,
          icon: new Icon(
            Icons.check,
            color: Colors.black,
          ),
          onPressed: () {
            if(_userName == null || _userName == ""){
              return;
            }
            if(_code == null || _code == ""){
              return;
            }
            CommonUtils.showLoadingDialog(context);
            MUserDao.updateInfo({"phone": _userName, "code": _code}).then((res) {
              Navigator.pop(context);
              if (res.success) {
                if (res.data.code == 200) {
                  MUserEntity userInfo = store.state.userInfo;
                  userInfo.phone = _userName;
                  store.dispatch(new MUpdateUserAction(userInfo));
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: res.data.message);
                }
              }
            });
          });
    });
  }
}
