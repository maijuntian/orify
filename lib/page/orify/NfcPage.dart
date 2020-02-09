import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar4.dart';

/**
 * Created by mai on 2019-11-20.
 */
class NfcPage extends StatefulWidget {
  @override
  _NfcPageState createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    startNFC();
  }

  Future<void> startNFC() async {
    if(MConstant.isInitNfc)
      return;
    print('NFC: Scan started');
    print('NFC: Scan readed NFC tag');
    MConstant.isInitNfc = true;
    FlutterNfcReader.read.listen((response) {
      print('NFC: Scan readed NFC response-->' +
          response.id +
          "  " +
          response.content +
          "  " +
          response.error);

      parseCode("https://" + response.content.substring(5));
    });
  }

  parseCode(String codeStr) {
    /* if (codeStr.contains("/a/")) {
      MUserDao.isLoginAsync().then((res) {
        if (res) {
          recognizeCode(codeStr);
        } else {}
      });
    } else {*/
    recognizeCode(codeStr);
//    }
  }

  recognizeCode(String codeStr) {
    print("code:$codeStr");
    if (isLoading) return;
    isLoading = true;
    if (codeStr.contains("intelliger.cn")) {
      CommonUtils.showLoadingDialog(context);
      MUserDao.authentication(codeStr).then((res) {
        Navigator.pop(context);
        if (res.success) {
          if (res.data.code == 200 ||
              res.data.code == 410 ||
              res.data.code == 208) {
            MNavigatorUtils.goTracingResultPage(
                context, res.data.getObject(), res.data.code);
          } else {
            Fluttertoast.showToast(
                msg: CommonUtils.getLocale(context).illegalCodeTip);
            Navigator.pop(context);
          }
        } else {
          isLoading = false;
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: CommonUtils.getLocale(context).illegalCodeTip);
      Navigator.pop(context);
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            GSYICons.DEFAULT_IMAGE_PATH + "main_bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
            backgroundColor: Color(MColors.trans),
            body: SafeArea(
                child: Column(
              children: <Widget>[
                MTitleBarCommon(
                  CommonUtils.getLocale(context).Scan,
                  backIcon: GSYICons.DEFAULT_IMAGE_PATH + "top_icon_back1.png",
                  style: MConstant.normalTextWhite,
                ),
                Padding(
                  padding: EdgeInsets.all(90),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize:MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      CommonUtils.getLocale(context).NFC_tip1,
                      style: MConstant.smallTextWhite,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Image.asset(
                      GSYICons.DEFAULT_IMAGE_PATH + "nfc_logo.png",
                      height: 23,
                      width: 36,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      CommonUtils.getLocale(context).NFC_tip2,
                      style: MConstant.smallTextWhite,
                    ),
                  ],
                ),
                Text(
                  CommonUtils.getLocale(context).NFC_tip3,
                  style: MConstant.smallTextWhite,
                ),
                Padding(
                  padding: EdgeInsets.all(23),
                ),
                Image.asset(
                  GSYICons.DEFAULT_IMAGE_PATH + "sketch_map_nfc.png",
                  height: 288,
                  width: 197,
                ),
              ],
            )))
      ],
    );
  }

  @override
  void dispose() {
//    stopNFC();
    super.dispose();
  }
}
