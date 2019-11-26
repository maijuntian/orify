import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';

class DemoQrcode extends StatefulWidget {
  @override
  _DemoQrcodeState createState() => new _DemoQrcodeState();
}

class _DemoQrcodeState extends State<DemoQrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    MUserDao.login("yesy", "feihfe").then((res){
//      if(res.success){
//        if(res.data.code == 200){
//          print("登录成功..."+res.data.getObject().name);
//        } else {
//          Fluttertoast.showToast(msg: res.data.message);
//        }
//      }
//    });

//    MUserDao.userInfo().then((res){
//      if(res.success){
//        if(res.data.code == 200){
//          print("登录成功..."+res.data.getObject().name);
//        } else {
//          Fluttertoast.showToast(msg: res.data.message);
//        }
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan result: $qrText'),
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
                onPressed: () async {
                  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final rest = await FlutterQrReader.imgScan(image);
                  setState(() {
                    qrText = rest;
                  });
                },
                child: Text("识别图片")),
          ),

        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}