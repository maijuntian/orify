import 'package:flutter/widgets.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/page/orify/BaseTitlePage.dart';


/**
 * Created by mai on 2019-12-23.
 */
class TracingResultsPage extends StatefulWidget {
  @override
  _TracingResultsPageState createState() => _TracingResultsPageState();
}

class _TracingResultsPageState extends BaseTitlePage<TracingResultsPage> {
  @override
  Widget body(BuildContext context) {
    return null;
  }

  @override
  String title(BuildContext context) {
    return CommonUtils.getLocale(context).Tracing_Results;
  }
}
