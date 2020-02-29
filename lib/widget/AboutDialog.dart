import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';

/**
 * Created by mai on 2019-12-31.
 */
class AboutDialog extends StatefulWidget {
  String url;
  String name;
  String content;

  @override
  _AboutDialogState createState() => _AboutDialogState();

  AboutDialog(this.url, this.name, this.content);
}

class _AboutDialogState extends State<AboutDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: new Container(
          height: MediaQuery.of(context).size.height - 80,
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
                height: 400,
                width: 280,
                decoration: new BoxDecoration(
                  //用一个BoxDecoration装饰器提供背景图片
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(13)),
                    new FadeInImage.assetNetwork(
                      fadeInDuration: Duration(milliseconds: 300),
                      fit: BoxFit.contain,
                      image: widget.url,
                      width: 244.0,
                      height: 122.0,
                      placeholder: GSYICons.DEFAULT_IMAGE_PATH + "logo_orify.png",
                    ),
                    Padding(padding: EdgeInsets.all(11)),
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 18, right: 18),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.content,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(13)),
                    CommonUtils.renderDivider(),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          CommonUtils.getLocale(context).Close,
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
