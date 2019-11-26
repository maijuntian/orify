import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';

/**
 * 欢迎页
 * Created by mai
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  /*NfcData _nfcData;

  @override
  void initState() {
    super.initState();
  }

  Future<void> startNFC() async {
    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    print('NFC: Scan started');

    print('NFC: Scan readed NFC tag');
    FlutterNfcReader.read.listen((response) {
      print('NFC: Scan readed NFC response-->'+response.id + "  " + response.content +"  " + response.error);
      setState(() {
        _nfcData = response;
      });
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

    try {
      print('NFC: Stop scan by user');
      response = await FlutterNfcReader.stop;
    } on PlatformException {
      print('NFC: Stop scan exception');
      response = NfcData(
        id: '',
        content: '',
        error: 'NFC scan stop exception',
        statusMapper: '',
      );
      response.status = NFCStatus.error;
    }

    setState(() {
      _nfcData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin example app'),
          ),
          body: new SafeArea(
            top: true,
            bottom: true,
            child: new Center(
              child: ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Text(
                    '- NFC Status -\n',
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    _nfcData != null ? 'Status: ${_nfcData.status}' : '',
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    _nfcData != null ? 'Identifier: ${_nfcData.id}' : '',
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    _nfcData != null ? 'Content: ${_nfcData.content}' : '',
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    _nfcData != null ? 'Error: ${_nfcData.error}' : '',
                    textAlign: TextAlign.center,
                  ),
                  new RaisedButton(
                    child: Text('Start NFC'),
                    onPressed: () {
                      startNFC();
                    },
                  ),
                  new RaisedButton(
                    child: Text('Stop NFC'),
                    onPressed: () {
                      stopNFC();
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }*/

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<MaiState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(milliseconds: 500), () {
      MUserDao.isLoginAsync().then((res) {
        if (res) {
          print("开始获取用户信息--->");
          return MUserDao.userInfo(store);
        } else {
          return null;
        }
      }).then((res) {
        if (res != null) {
          if (res.success && res.data.code == 200) {
            _home(store, res.data.getObject().region);
          } else {
            MUserDao.clearUserInfo();
            _region(store);
          }
        } else {
          _region(store);
        }
      });
    });
  }

  _region(store) {
    MUserDao.region().then((res) {
      print(res);
      if (res.success && res.data.code == 200) {
        _home(store, res.data.getString());
      }
    });
  }

  _home(store, region) {
    CommonUtils.changeLocale(store, region);
    NavigatorUtils.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MaiState>(
      builder: (context, store) {
        return new Container(
          child: Stack(
            children: <Widget>[
              new Expanded(
                child: new Image(
                    image: new AssetImage('static/images/main_bg.png')),
              ),
              Center(
                  child: Row(
                children: <Widget>[
                  new Image(image: new AssetImage('static/images/logo.png')),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
