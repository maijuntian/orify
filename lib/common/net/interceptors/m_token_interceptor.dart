import 'package:dio/dio.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';

/**
 * Token拦截器
 * Created by mai
 * on 2019/3/23.
 */
class MTokenInterceptors extends InterceptorsWrapper {
  String _version;
  String _token;

  String _region;
  String _deviceId;
  String _longitude, _latitude;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers["Authorization"] = _token;

    if (_version != null) options.headers["Version"] = _version;

    if (_region != null) options.headers["Region"] = _region;

    if (_deviceId != null) options.headers["deviceID"] = _deviceId;

    if (_longitude != null && _latitude != null)
      options.headers["Gps"] =
          "longitude=" + _longitude + ";latitude=" + _latitude;

    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      if (response.headers.value("authorization") != null) {
        _token = response.headers.value("authorization");
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token;
  }

  set latitude(value) {
    _latitude = value;
  }

  set longitude(value) {
    _longitude = value;
  }

  set deviceId(value) {
    _deviceId = value;
  }

  set region(value) {
    _region = value;
  }

  set version(value) {
    _version = value;
  }
}
