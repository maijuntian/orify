import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/redux/mai_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar2.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar3.dart';
import 'package:gsy_github_app_flutter/widget/m_title_bar4.dart';

/**
 * Created by mai on 2020-02-09.
 */
class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<MaiState>(builder: (context, store) {
      MUserEntity user = store.state.userInfo;

      return new Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              GSYICons.DEFAULT_IMAGE_PATH + "main_bg.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            children: <Widget>[
              MTitleBarCommon(
                CommonUtils.getLocale(context).Store,
                backIcon: GSYICons.DEFAULT_IMAGE_PATH+"top_icon_home.png",
              ),
              Container(
                padding: EdgeInsets.only(left: 24, right: 24,top: 12, bottom: 12),
                color: Color(0xfff6f6f6),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new ClipOval(
                          child: new FadeInImage.assetNetwork(
                            fadeInDuration: Duration(milliseconds: 300),
                            image: user.icon == null
                                ? GSYICons.DEFAULT_IMAGE_PATH +
                                "icon_login_in.png"
                                : user.icon,
                            fit: BoxFit.cover,
                            width: 40.0,
                            height: 40.0,
                            placeholder: GSYICons.DEFAULT_IMAGE_PATH +
                                "icon_login_in.png",
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        Text("${user.points} ${CommonUtils.getLocale(context).Points}"
                        ,style: MConstant.middleTextBlack,),
                        Expanded(
                          child: Image.asset(GSYICons.DEFAULT_IMAGE_PATH+"bt_integral2.png", height: 32, width: 32,),
                        ),
                        Padding(padding: EdgeInsets.all(9),),
                        Image.asset(GSYICons.DEFAULT_IMAGE_PATH+"bt_integral2.png", height: 32, width: 32,),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
