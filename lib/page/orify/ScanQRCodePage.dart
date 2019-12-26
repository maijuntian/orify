import 'package:flutter/widgets.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar5.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';

/**
 * 扫码界面
 * Created by mai on 2019-11-18.
 */
class ScanQRCodePage extends StatefulWidget {
  @override
  _ScanQRCodePageState createState() => new _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage>
    with SingleTickerProviderStateMixin {
  var qrText = "";
  QRViewController controller;

  //动画控制器
  AnimationController animController;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    //初始化
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    animController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        //ontroller.reverse();
        animController.reset();
        animController.forward();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        //controller.forward();
      }
    });
    animation =
        Tween(begin: Offset.zero, end: Offset(0, 1)).animate(animController);

    //开始执行动画
    animController.forward();
  }

  parseCode(String codeStr){

      if (codeStr.contains("/a/")) {
        MUserDao.isLoginAsync().then((res) {
          if (res) {
            recognizeCode(codeStr);
          } else {

          }
        });
      } else {
        recognizeCode(codeStr);
      }
  }



  recognizeCode(String codeStr) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: _onQRViewCreated,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              width: 200,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    GSYICons.DEFAULT_IMAGE_PATH + "shape_scan.png",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  SlideTransition(
                    position: animation,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Container(
                        height: 1,
                        width: 100,
                        color: Color(0xff00ff00),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: MRightTextTitleBarCommon(
              rightText: CommonUtils.getLocale(context).Album,
              onTap: ()async {
                File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                final rest = await FlutterQrReader.imgScan(image);
                setState(() {
                  qrText = rest;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    animController?.dispose();
    super.dispose();
  }
}
