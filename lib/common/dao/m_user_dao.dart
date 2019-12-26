import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/dao/m_dao_result.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/model/region_entity.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/net/m_api.dart';
import 'package:gsy_github_app_flutter/common/redux/m_user_redux.dart';

class MUserDao {
  static Future<MDataResult<Object>> login(username, password) async {
    var res = await mHttpManager.netFetch(
        MAddress.getLogin(),
        {"username": username, "password": password},
        null,
        new Options(method: "POST"));
    return new MDataResult<Object>(res);
  }

  static Future<MDataResult<MUserEntity>> userInfo(store) async {
    MDataResult<MUserEntity> res = new MDataResult<MUserEntity>(
        await mHttpManager.netFetch(MAddress.getUserInfo(), null, null, null));

    if (res.success && res.data.code == 200) {
      await LocalStorage.save(
          Config.USER_INFO, json.encode(res.data.getObject().toJson()));
      store.dispatch(new MUpdateUserAction(res.data.getObject()));
    }
    return res;
  }

  static Future<MUserEntity> userInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      MUserEntity user = MUserEntity.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  static clearUserInfo(store) {
    mHttpManager.clearAuthorization();
    LocalStorage.remove(Config.USER_INFO);
    store.dispatch(new MUpdateUserAction(MUserEntity.empty()));
  }

  static Future<bool> isLoginAsync() async {
    var token = await mHttpManager.getAuthorization();
    return token != null;
  }

  static Future<MDataResult<Object>> updateInfo(Map<String, dynamic> params) async {
    return new MDataResult<MUserEntity>(await mHttpManager.netFetch(
        MAddress.getUpdateInfo(), params, null, new Options(method: "PUT")));
  }

  static Future<MDataResult<String>> updateAvatar(File image) async {
    FormData params =
        new FormData.from({"file": new UploadFileInfo(image, "image.png")});

    var res = await mHttpManager.netFetch(MAddress.getUpdateAvatar(), params,
        {"Content-Type": "multipart/form-data"}, new Options(method: "POST"));
    return new MDataResult<String>(res, type: 0);
  }

  static Future<MDataResult<Object>> snsCode(phone) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getSnsCode(phone), null, null, new Options(method: "POST")));
  }

  static Future<MDataResult<Object>> emailCode(email) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getEmailCode(email), null, null, new Options(method: "POST")));
  }

  static Future<MDataResult<Object>> emailCode2(email) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getEmailCode2(email),
        null,
        null,
        new Options(method: "POST")));
  }

  static Future<MDataResult<Object>> phoneRegister(
      name, password, verificationCode) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getPhoneRegister(),
        {
          "name": name,
          "password": password,
          "verificationCode": verificationCode
        },
        null,
        new Options(method: "POST")));
  }

  static Future<MDataResult<Object>> resetPwd(
      name, password, verificationCode) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getPhoneRegister(),
        {
          "name": name,
          "password": password,
          "verificationCode": verificationCode
        },
        null,
        new Options(method: "POST")));
  }

  static Future<MDataResult<Object>> emailRegister(
      name, password, verificationCode) async {
    return new MDataResult<Object>(await mHttpManager.netFetch(
        MAddress.getEmailRegister(),
        {
          "name": name,
          "password": password,
          "verificationCode": verificationCode
        },
        null,
        new Options(method: "POST")));
  }

  static Future<MDataResult<String>> region() async {
    return new MDataResult<String>(
        await mHttpManager.netFetch(MAddress.getRegion(), null, null, null), type: 0);
  }

  static Future<MDataResult<String>> authentication(String url) async {
    return new MDataResult<String>(
        await mHttpManager.netFetch(url, null, null, null), type: 0);
  }
}
