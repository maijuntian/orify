import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

class MIconText extends StatelessWidget {
  final String icon;

  final String text;

  final double size;

  final double padding;

  final TextStyle style;

  final MainAxisAlignment mainAxisAlignment;

  MIconText(this.icon, this.text, {this.size = 20, this.padding = 10,this.mainAxisAlignment = MainAxisAlignment.center, this.style = MConstant.smallTextWhite});

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Image.asset(this.icon ,height: size, width: size,),
        Padding(padding: EdgeInsets.only(right: padding)),
        Text(text, style: style,)
      ],
    );
  }
}
