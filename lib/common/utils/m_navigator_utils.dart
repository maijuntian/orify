import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/model/tracing_result_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/m_user_redux.dart';
import 'package:gsy_github_app_flutter/common/router/anima_route.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/page/code_detail_page_web.dart';
import 'package:gsy_github_app_flutter/page/common_list_page.dart';
import 'package:gsy_github_app_flutter/page/gsy_webview.dart';
import 'package:gsy_github_app_flutter/page/honor_list_page.dart';
import 'package:gsy_github_app_flutter/page/issue_detail_page.dart';
import 'package:gsy_github_app_flutter/page/notify_page.dart';
import 'package:gsy_github_app_flutter/page/orify/ForgotPwdPage.dart';
import 'package:gsy_github_app_flutter/page/orify/HomePage.dart';
import 'package:gsy_github_app_flutter/page/orify/LoginPage.dart';
import 'package:gsy_github_app_flutter/page/orify/NfcPage.dart';
import 'package:gsy_github_app_flutter/page/orify/RankInterestsPage.dart';
import 'package:gsy_github_app_flutter/page/orify/RegisterPage.dart';
import 'package:gsy_github_app_flutter/page/orify/ScanQRCodePage.dart';
import 'package:gsy_github_app_flutter/page/orify/TracingResultPage.dart';
import 'package:gsy_github_app_flutter/page/orify/UserInfoPage.dart';
import 'package:gsy_github_app_flutter/page/orify/UserMobilePage.dart';
import 'package:gsy_github_app_flutter/page/orify/VerificationRecordPage.dart';
import 'package:gsy_github_app_flutter/page/orify/WebViewPage.dart';
import 'package:gsy_github_app_flutter/page/person_page.dart';
import 'package:gsy_github_app_flutter/page/photoview_page.dart';
import 'package:gsy_github_app_flutter/page/push_detail_page.dart';
import 'package:gsy_github_app_flutter/page/release_page.dart';
import 'package:gsy_github_app_flutter/page/repository_detail_page.dart';
import 'package:gsy_github_app_flutter/page/search_page.dart';
import 'package:gsy_github_app_flutter/page/user_profile_page.dart';
import 'package:gsy_github_app_flutter/widget/AboutDialog.dart' as prefix0;
import 'package:gsy_github_app_flutter/widget/BirthdayDialog.dart';
import 'package:gsy_github_app_flutter/widget/FeedBackDialog.dart';

/**
 * 导航栏
 * Created by mai
 * Date: 2018-07-16
 */
class MNavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static goLogin(BuildContext context) {
    return NavigatorRouter(context, new LoginPage());
  }

  static replaceLogin(BuildContext context) {
    return NavigatorRouterReplace(context, new LoginPage());
  }

  static goRegisterPage(BuildContext context) {
    return NavigatorRouter(context, new RegisterPage());
  }

  static goForgotPwdPage(BuildContext context) {
    return NavigatorRouter(context, new ForgotPwdPage());
  }

  static goScanQRCodePage(BuildContext context) {
    return NavigatorRouter(context, new ScanQRCodePage());
  }

  static goUserInfoPage(BuildContext context) {
    return NavigatorRouter(context, new UserInfoPage());
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static goVerificationRecord(BuildContext context) {
    NavigatorRouter(context, new VerificationRecordPage());
  }

  static goRankInterestsPage(BuildContext context) {
    NavigatorRouter(context, new RankInterestsPage());
  }

  static goWebViewPage(BuildContext context, String url, String title) {
    NavigatorRouter(context, new WebViewPage(url, title));
  }

  static goUserMobilePage(BuildContext context) {
    NavigatorRouter(context, new UserMobilePage());
  }

  static goTracingResultPage(BuildContext context, TracingResultEntity entity, int code) {
    NavigatorRouterReplace(context, new TracingResultPage(entity, code));
  }

  static goNfcPage(BuildContext context) {
    NavigatorRouter(context, new NfcPage());
  }

  ///仓库详情通知
  static Future goNotifyPage(BuildContext context) {
    return NavigatorRouter(context, new NotifyPage());
  }

  ///搜索
  static Future goSearchPage(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(builder: (BuildContext context) {
          return pageContainer(SearchPage());
        });
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  ///提交详情
  static Future goPushDetailPage(BuildContext context, String userName,
      String reposName, String sha, bool needHomeIcon) {
    return NavigatorRouter(
        context,
        new PushDetailPage(
          sha,
          userName,
          reposName,
          needHomeIcon: needHomeIcon,
        ));
  }

  ///全屏Web页面
  static Future goGSYWebView(BuildContext context, String url, String title) {
    return NavigatorRouter(context, new GSYWebView(url, title));
  }

  ///文件代码详情Web
  static gotoCodeDetailPageWeb(BuildContext context,
      {String title,
      String userName,
      String reposName,
      String path,
      String data,
      String branch,
      String htmlUrl}) {
    NavigatorRouter(
        context,
        new CodeDetailPageWeb(
          title: title,
          userName: userName,
          reposName: reposName,
          path: path,
          data: data,
          branch: branch,
          htmlUrl: htmlUrl,
        ));
  }

  ///根据平台跳转文件代码详情Web
  static gotoCodeDetailPlatform(BuildContext context,
      {String title,
      String userName,
      String reposName,
      String path,
      String data,
      String branch,
      String htmlUrl}) {
    MNavigatorUtils.gotoCodeDetailPageWeb(
      context,
      title: title,
      reposName: reposName,
      userName: userName,
      data: data,
      path: path,
      branch: branch,
    );
  }

  ///图片预览
  static gotoPhotoViewPage(BuildContext context, String url) {
    NavigatorRouter(context, new PhotoViewPage(url));
  }

  ///用户配置
  static gotoUserProfileInfo(BuildContext context) {
    NavigatorRouter(context, new UserProfileInfo());
  }

  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context,
        new CupertinoPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///公共打开方式
  static NavigatorRouterReplace(BuildContext context, Widget widget) {
    return Navigator.pushReplacement(context,
        new CupertinoPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }

  static showBirthdayDialog(BuildContext context, store) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          Container(height: 200, child: BirthdayDialog()),
    ).then((val) {
      if (MConstant.birthDaySet == "") return;
      CommonUtils.showLoadingDialog(context);
      MUserDao.updateInfo({"birthday": MConstant.birthDaySet}).then((res) {
        Navigator.pop(context);
        if (res.success) {
          if (res.data.code == 200) {
            MUserEntity userInfo = store.state.userInfo;
            userInfo.birthday = MConstant.birthDaySetEN;
            store.dispatch(new MUpdateUserAction(userInfo));
          } else {
            Fluttertoast.showToast(msg: res.data.message);
          }
        }
      });
    });
  }

  static showFeedBackDialog(BuildContext context, code) {
    showGSYDialog(
      context: context,
      builder: (BuildContext context) =>Center(
          child: FeedBackDialog(code),
          ),
    );
  }

  static showAboutDialog(BuildContext context, url, name, content) {
    showGSYDialog(
      context: context,
      builder: (BuildContext context) =>
          prefix0.AboutDialog(url, name, content),
    );
  }

  static showChooseDialog(
      BuildContext context,
      String text1,
      String text2,
      GestureTapCallback callback1,
      GestureTapCallback callback2,
      bool check1,
      bool check2) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          color: Colors.white,
          height: 135,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      text1,
                      style: check1
                          ? MConstant.middleTextBlue
                          : MConstant.middleTextBlack,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 20, bottom: 26),
                ),
                onTap: callback1,
              ),
              CommonUtils.renderDivider(),
              GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      text2,
                      style: check2
                          ? MConstant.middleTextBlue
                          : MConstant.middleTextBlack,
                      maxLines: 4,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 20, bottom: 26),
                ),
                onTap: callback2,
              ),
            ],
          )),
    ).then((val) {});
  }

  ///弹出 dialog
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}
