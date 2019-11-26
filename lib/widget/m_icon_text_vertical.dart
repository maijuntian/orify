import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';

class MIconTextVertical extends StatelessWidget {
  final String icon;

  final String text;

  final double padding;

  final double size;

  final TextStyle style;

  MIconTextVertical(this.icon, this.text, {this.size = 30, this.padding = 10, this.style = MConstant.middleTextWhite});

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(this.icon, height: size, width: size,),
        Padding(padding: EdgeInsets.all(padding)),
        Text(text, style: style,)
      ],
    );
  }
}
