import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/m_user_dao.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';

/**
 * Created by mai on 2019-12-31.
 */
class FeedBackDialog extends StatefulWidget {
  String code;

  @override
  _FeedBackDialogState createState() => _FeedBackDialogState();

  FeedBackDialog(this.code);
}

class _FeedBackDialogState extends State<FeedBackDialog> {
  String content;

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.value = new TextEditingValue(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Container(
            height: MediaQuery.of(context).size.height-80,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,

            ///触摸收起键盘
            child: new GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pop(context);
              },
              child: new Center(
                child: Container(
                  height: 290,
                  width: 280,
                  decoration: new BoxDecoration(
                    //用一个BoxDecoration装饰器提供背景图片
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(16)),
                      Text(
                        CommonUtils.getLocale(context).Feedback,
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 13, bottom: 13, left: 18, right: 18),
                        child: Text(
                          CommonUtils.getLocale(context).Feedback_tip,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff9B9B9B),
                          ),
                        ),
                      ),

                      ///内容输入框
                      new Container(
                        height: 110,
                        width: 244,
                        child: new TextField(
                          autofocus: false,
                          maxLines: 999,
                          onChanged: (String value) {
                            content = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          controller: controller,
                          style: MConstant.middleTextBlack,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(13)),
                      CommonUtils.renderDivider(),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Text(
                            CommonUtils.getLocale(context).Send,
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (content == null || content.length == 0) {
                            return;
                          }
                          CommonUtils.showLoadingDialog(context);
                          MUserDao.feedback(widget.code, content).then((res) {
                            Navigator.pop(context);
                            if (res.success) {
                              Fluttertoast.showToast(msg: res.data.message);
                              if (res.data.code == 200) {
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
