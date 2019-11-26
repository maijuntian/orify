
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DemoWebview extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(url: "https://www.baidu.com");
  }

}