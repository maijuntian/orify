import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/m_user_redux.dart';
import 'package:gsy_github_app_flutter/common/redux/middleware/epic_middleware.dart';
import 'package:gsy_github_app_flutter/common/redux/locale_redux.dart';
import 'package:redux/redux.dart';

/**
 * Redux全局State
 * Created by mai
 * Date: 2018-07-16
 */

///全局Redux store 的对象，保存State数据
class MaiState {
  ///用户信息
  MUserEntity userInfo;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///构造方法
  MaiState({this.userInfo, this.locale});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
MaiState mAppReducer(MaiState state, action) {
  return MaiState(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: MUserReducer(state.userInfo, action),

    ///通过 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
    locale: LocaleReducer(state.locale, action),
  );
}

final List<Middleware<MaiState>> mMiddleware = [
  EpicMiddleware<MaiState>(MUserInfoEpic()),
  MUserInfoMiddleware(),
];