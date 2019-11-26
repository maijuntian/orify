import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/User.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/redux/middleware/epic.dart';
import 'package:gsy_github_app_flutter/common/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 用户相关Redux
 * Created by mai
 * Date: 2018-07-16
 */

/// redux 的 combineReducers, 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final MUserReducer = combineReducers<MUserEntity>([
  TypedReducer<MUserEntity, MUpdateUserAction>(_updateLoaded),
]);

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateLoaded
/// _updateLoaded 这里接受一个新的userInfo，并返回
MUserEntity _updateLoaded(MUserEntity user, action) {
  user = action.userInfo;
  return user;
}

///定一个 UpdateUserAction ，用于发起 userInfo 的的改变
///类名随你喜欢定义，只要通过上面TypedReducer绑定就好
class MUpdateUserAction {
  final MUserEntity userInfo;

  MUpdateUserAction(this.userInfo);
}

class FetchUserAction {
}


class MUserInfoMiddleware implements MiddlewareClass<MaiState> {

  @override
  void call(Store<MaiState> store, dynamic action, NextDispatcher next) {
    if (action is MUpdateUserAction) {
      print("*********** UserInfoMiddleware *********** ");
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}

class MUserInfoEpic implements EpicClass<MaiState> {
  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<MaiState> store) {
    return Observable(actions)
        // to UpdateUserAction actions
        .ofType(TypeToken<FetchUserAction>())
        // Don't start  until the 10ms
        .debounce(((_) => TimerStream(true, const Duration(milliseconds: 10))))
        .switchMap((action) => _loadUserInfo(store));
  }

  // Use the async* function to make easier
  Stream<dynamic> _loadUserInfo(store) async* {
    print("*********** userInfoEpic _loadUserInfo ***********");
    var res = await MUserDao.userInfo(store);
    yield MUpdateUserAction(res.data.getObject());
  }
}