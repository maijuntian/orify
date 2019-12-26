import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

/// 带图标的输入框
class MPwdInputWidget extends StatefulWidget {
  final String hintText;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  MPwdInputWidget(
      {Key key,
      this.hintText,
      this.onChanged,
      this.textStyle,
      this.controller})
      : super(key: key);

  @override
  _MPwdInputWidgetState createState() => new _MPwdInputWidgetState();
}

/// State for [GSYInputWidget] widgets.
class _MPwdInputWidgetState extends State<MPwdInputWidget> {
  _MPwdInputWidgetState() : super();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Theme(
          data: new ThemeData(primaryColor: Color(0xff4A4A4A)),
          child: new TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            maxLines: 1,
            style: MConstant.smallTextBlack,
            obscureText: obscureText,
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              hintText: widget.hintText,
              hintStyle: MConstant.smallTextGray,
            ),
          ),
        ),
        Container(
            height: 50,
            child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 15),
                    child: Image(
                      image: AssetImage(GSYICons.DEFAULT_IMAGE_PATH+(obscureText?"close_eyes.png":"open_eyes.png")),
                      height: 15,
                      width: 15,
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ))),
      ],
    );
  }
}
