import 'package:gsy_github_app_flutter/common/config/config.dart';

///网络请求路径
class MAddress {
  static const String host = "https://api.intelliger.cn/v1/";

  static getLogin() {
    return "${host}user/auth/login";
  }

  static getPhoneLogin() {
    return "${host}user/auth/login/phone";
  }

  static getUserInfo() {
    return "${host}user/info";
  }

  static getPoints() {
    return "${host}user/points";
  }

  static getAddress() {
    return "${host}user/info/address";
  }

  static getAddressDefault() {
    return "${host}user/info/address/default";
  }

  static getAuthRecord() {
    return "${host}user/source/authentication";
  }

  static getUpdateInfo() {
    return "${host}user/info/base";
  }

  static getUpdateInfoPhone() {
    return "${host}user/info/base/phone";
  }

  static getUpdateAvatar() {
    return "${host}user/info/base/avatar";
  }

  static getCheckIn() {
    return "${host}user/check-in";
  }

  static getRedeem(code) {
    return "${host}/mall/product/${code}/redeem";
  }

  static getSnsCode(phone) {
    return "${host}system/sns/verification/${phone}";
  }

  static getEmailCode(email) {
    return "${host}system/email/verification/${email}";
  }

  static getEmailCode2(email) {
    return "${host}system/email/reset/password/${email}";
  }

  static getPhoneRegister() {
    return "${host}system/register/phone";
  }

  static getResetPwd() {
    return "${host}system/reset/password";
  }

  static getEmailRegister() {
    return "${host}system/register/email";
  }

  static getRegion() {
    return "${host}system/region";
  }

  static getVersion(version) {
    return "${host}system/app/version/${version}";
  }

  static getFacebookLogin() {
    return "${host}user/auth/login/facebook";
  }

  static getGoogleLogin() {
    return "${host}user/auth/login/google";
  }

  static getUserAgreement(){
    return "${host}system/user/agreement?lang=EN";
  }

  static getAbout(){
    return "${host}system/about/us";
  }

  static getRecord() {
    return "https://api.intelliger.cn/v1/user/source/authentication";
  }

  static getIOSVersion(id){
    return "http://itunes.apple.com/cn/lookup?id=${id}";
  }
}
