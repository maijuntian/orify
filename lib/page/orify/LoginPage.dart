import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/dao/event_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/redux/user_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/gsy_nested_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/widget/state/base_person_state.dart';
import 'package:redux/redux.dart';

/**
 * 主页我的tab页
 * Created by mai
 * Date: 2018-07-16
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _login(store) {
    MUserDao.login("z03jr124@163.com", "test").then((res) {
      if (res.success) {
        if (res.data.code == 200) {
          return MUserDao.userInfo(store);
        }
      }
      return new Future.value(null);
    }).then((res) {
      if (res != null && res.success) {
        if (res.data.code == 200) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<MaiState>(
      builder: (context, store) {
        return new Scaffold(
            backgroundColor: Color(GSYColors.mainBackgroundColor),
            body: Center(
              child: new FlatButton(onPressed: _login(store), child: new Text("登录")),
            ));
      },
    );
  }
}
