import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gsy_github_app_flutter/common/model/Event.dart';
import 'package:gsy_github_app_flutter/common/model/RepoCommit.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/event_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';
import 'package:gsy_github_app_flutter/widget/gsy_user_icon_widget.dart';
import 'package:gsy_github_app_flutter/common/model/Notification.dart' as Model;
import 'package:webview_flutter/webview_flutter.dart';

/**
 * 事件Item
 * Created by mai
 * Date: 2018-07-16
 */
class ResultMap extends StatelessWidget {
  final String location;
  final String url;
  final double radius;
  final EdgeInsets margin;

  ResultMap(this.location, this.url, {this.radius = 4.0, this.margin}) : super();

  @override
  Widget build(BuildContext context) {

    EdgeInsets margin = this.margin;
    margin ??= EdgeInsets.only(left: 16, right: 16, top: 9, bottom: 0);

    return new Container(
      child: new GSYCardItem(
        radius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
        child: Padding(
            padding: EdgeInsets.only(left: 26, right: 26, top: 28, bottom: 29),
            child: Column(
              children: <Widget>[
                Text(
                  CommonUtils.getLocale(context).LOCATIONS,
                  style: MConstant.middleTextBlack,
                ),
                Padding(
                  padding: EdgeInsets.all(9),
                ),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff9B9B9B),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(9),
                ),
                Container(
                  height: 165,
                  child: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,

                  )/*new WebviewScaffold(url: url, )*/,
                )
              ],
            )),
        margin: margin,
      ),
    );
  }
}
