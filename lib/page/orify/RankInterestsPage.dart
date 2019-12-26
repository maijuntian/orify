import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/net/m_address.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/m_navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';

/**
 * Created by mai on 2019-12-25.
 */
class RankInterestsPage extends StatefulWidget {
  @override
  _RankInterestsPageState createState() => _RankInterestsPageState();
}

class _RankInterestsPageState extends BaseTitlePage<RankInterestsPage> {
  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              GSYICons.DEFAULT_IMAGE_PATH + "integral_details_en.png",
            ),
            color: Colors.white,
          ),

          Padding(
            padding: EdgeInsets.all(10),
          ),
          GestureDetector(
              onTap: () {
                MNavigatorUtils.goWebViewPage(
                    context,
                    MAddress.getUserAgreement(),
                    CommonUtils.getLocale(context).User_Agreement2);
              },
              child: Container(
                color: Color(GSYColors.white),
                padding:
                    EdgeInsets.only(left: 16, right: 10, top: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Text(CommonUtils.getLocale(context).User_Agreement2),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          GSYICons.DEFAULT_IMAGE_PATH + "icon_arrow.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    ));
  }

  @override
  String title(BuildContext context) {
    // TODO: implement title
    return CommonUtils.getLocale(context).Ranks_and_Interests;
  }
}
