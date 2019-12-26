import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';


/**
 * Created by mai on 2019-12-23.
 */
class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends BaseTitlePage<WebViewPage> {

  @override
  Widget body(BuildContext context) {

    /*let headers = {"user-agent": "viverify"};
    headers.Region = Constant.REGION;

    if (Constant.latitude !== "" && Constant.longitude !== "") {
      headers.Gps = "longitude=" + Constant.longitude + ";latitude=" + Constant.latitude;
    }
    headers.Version = Constant.VERSION;
    if (Constant.DEVICE_ID !== "")
      headers.Device_Id = Constant.DEVICE_ID;*/

    Map<String, String> headers = {"user-agent": "viverify"};
    return Expanded(
      child: new WebviewScaffold(url: widget.url),
    );
  }

  @override
  String title(BuildContext context) {
    return widget.title;
  }
}
