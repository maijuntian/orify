import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/m_user_redux.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

/**
 * Created by mai on 2019-12-17.
 */
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends BaseTitlePage<UserInfoPage> {
  double itemWidth = 600;
  var name = "";
  var email = "";

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    MUserDao.userInfoLocal().then((res) {
      if (res != null) {
        name = res.name;
        email = res.email;
        nameController.value = new TextEditingValue(text: res.name ?? "");
        emailController.value = new TextEditingValue(text: res.email ?? "");
      }
    });
  }

  _renderDivider() {
    return Container(
      color: Color(0xfff6f6f6),
      height: 0.5,
    );
  }

  @override
  Widget body(BuildContext context) {
    return new StoreBuilder<MaiState>(builder: (context, store) {
      MUserEntity user = store.state.userInfo;

      _uploadFile(File file) {
//        ImageCrop.cropImage(file: file, area: Rect.fromLTWH(0, 0, 100, 100))
//            .then((res) {
        CommonUtils.showLoadingDialog(context);
        MUserDao.updateAvatar(file).then((res2) {
          Navigator.pop(context);
          if (res2.success) {
            if (res2.data.code == 200) {
              MUserEntity userInfo = store.state.userInfo;
              userInfo.icon = res2.data.getString();
              store.dispatch(new MUpdateUserAction(userInfo));
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(msg: res2.data.message);
            }
          }
//          });
        });
      }

      return Expanded(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CommonUtils.getLocale(context).Profile,
                          style: MConstant.middleTextGray,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(5)),
                              new ClipOval(
                                child: new FadeInImage.assetNetwork(
                                  fadeInDuration: Duration(milliseconds: 300),
                                  image: user.icon == null
                                      ? GSYICons.DEFAULT_IMAGE_PATH +
                                      "icon_login_in.png"
                                      : user.icon,
                                  fit: BoxFit.cover,
                                  width: 40.0,
                                  height: 40.0,
                                  placeholder: GSYICons.DEFAULT_IMAGE_PATH +
                                      "icon_login_in.png",
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                onTap: () {
                  MNavigatorUtils.showChooseDialog(
                      context,
                      CommonUtils.getLocale(context).Select_from_album,
                      CommonUtils.getLocale(context).Take_a_picture, () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 100,
                        maxWidth: 100,
                        imageQuality: 50);
                    if (image == null) return;
                    _uploadFile(image);
                  }, () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                        maxHeight: 100,
                        maxWidth: 100,
                        imageQuality: 50);
                    if (image == null) return;
                    _uploadFile(image);
                  }, false, false);
                },
              ),
              _renderDivider(),
              Container(
                padding:
                EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        CommonUtils.getLocale(context).Name,
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
                          name = value;
                        },
                        controller: nameController,
                      ),
                    ),
                  ],
                ),
              ),
              _renderDivider(),
              GestureDetector(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CommonUtils.getLocale(context).Gender,
                          style: MConstant.middleTextGray,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              user.gender,
                              style: MConstant.middleTextBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  MNavigatorUtils.showChooseDialog(
                      context,
                      CommonUtils.getLocale(context).Male,
                      CommonUtils.getLocale(context).Female, () {
                    CommonUtils.showLoadingDialog(context);
                    MUserDao.updateInfo(
                        {"gender": CommonUtils.getLocale(context).Male})
                        .then((res) {
                      Navigator.pop(context);
                      if (res.success) {
                        if (res.data.code == 200) {
                          MUserEntity userInfo = store.state.userInfo;
                          userInfo.gender = CommonUtils.getLocale(context).Male;
                          store.dispatch(new MUpdateUserAction(userInfo));
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(msg: res.data.message);
                        }
                      }
                    });
                  }, () {
                    MUserDao.updateInfo(
                        {"gender": CommonUtils.getLocale(context).Female})
                        .then((res) {
                      Navigator.pop(context);
                      if (res.success) {
                        if (res.data.code == 200) {
                          MUserEntity userInfo = store.state.userInfo;
                          userInfo.gender = CommonUtils.getLocale(context).Female;
                          store.dispatch(new MUpdateUserAction(userInfo));
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(msg: res.data.message);
                        }
                      }
                    });
                  }, user.gender == CommonUtils.getLocale(context).Male,
                      user.gender == CommonUtils.getLocale(context).Female);
                },
              ),
              _renderDivider(),
              GestureDetector(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CommonUtils.getLocale(context).Mobile_Number,
                          style: MConstant.middleTextGray,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              user.phone,
                              style: MConstant.middleTextBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (user.phone == CommonUtils.getLocale(context).NULL) {
                    MNavigatorUtils.goUserMobilePage(context);
                  }
                },
              ),
              _renderDivider(),
              GestureDetector(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 30),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CommonUtils.getLocale(context).Date_of_Birth,
                          style: MConstant.middleTextGray,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              user.birthday,
                              style: MConstant.middleTextBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  MConstant.birthDay = user.birthday;
                  MNavigatorUtils.showBirthdayDialog(context, store);
                },
              ),
              _renderDivider(),
              Container(
                padding:
                EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        CommonUtils.getLocale(context).Email_address,
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
                          email = value;
                        },
                        controller: emailController,
                      ),
                    ),
                  ],
                ),
              ),
              _renderDivider(),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
              _renderDivider(),
              GestureDetector(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    CommonUtils.getLocale(context).Sign_out,
                    style: TextStyle(
                        color: Color(0xffff3333),
                        fontSize: MConstant.normalTextSize),
                  ),
                ),
                padding: EdgeInsets.only(top: 20, bottom: 26),
              ),
              onTap: () {
                //退出登录
                Navigator.pop(context);
                MUserDao.clearUserInfo(store);
              },
            ),
            ],
          ),
        ),
      );
    });
  }

  @override
  String title(BuildContext context) {
    return CommonUtils.getLocale(context).Profile;
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
            CommonUtils.showLoadingDialog(context);
            MUserDao.updateInfo({"name": name, "email": email}).then((res) {
              Navigator.pop(context);
              if (res.success) {
                if (res.data.code == 200) {
                  MUserEntity userInfo = store.state.userInfo;
                  userInfo.email = email;
                  userInfo.name = name;
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
