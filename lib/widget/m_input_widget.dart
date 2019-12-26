import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

/// 带图标的输入框
class MInputWidget extends StatefulWidget {
  final String hintText;

  final String iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;

  final GestureTapCallback tapCallback;

  final String rightText;

  final TextStyle rightTextStyle;

  MInputWidget(
      {Key key,
      this.hintText,
      this.iconData,
      this.onChanged,
      this.textStyle,
      this.controller,
      this.tapCallback,
      this.rightText,
      this.rightTextStyle = MConstant.smallTextBlack})
      : super(key: key);

  @override
  _MInputWidgetState createState() => new _MInputWidgetState();
}

/// State for [GSYInputWidget] widgets.
class _MInputWidgetState extends State<MInputWidget> {
  _MInputWidgetState() : super();

  Widget rightWidget() {
    if (widget.rightText == null) {
      return Container(
          height: 50,
          child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 15),
                  child: Image(
                    image: AssetImage(widget.iconData),
                    height: 15,
                    width: 15,
                  ),
                ),
                onTap: widget.tapCallback,
              )));
    } else {
      return Container(
          height: 50,
          child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 15),
                    child:
                        Text(widget.rightText, style: widget.rightTextStyle)),
                onTap: widget.tapCallback,
              )));
    }
  }

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
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              hintText: widget.hintText,
              hintStyle: MConstant.smallTextGray,
            ),
          ),
        ),
        rightWidget(),
      ],
    );
  }
}
