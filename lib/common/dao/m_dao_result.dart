import 'package:gsy_github_app_flutter/common/model/BaseResponse.dart';
import 'package:gsy_github_app_flutter/common/net/result_data.dart';

class MDataResult<T> {
  BaseResponse<T> data;
  bool success;

  /**
   * type  0 字符串   1对象  2数组
   */
  MDataResult(ResultData data,{type: 1}) {
    this.success = data.result;
    if (data.result) {
      if (type == 1)
        this.data = BaseResponse.fromJson(data.data);
      else if (type == 2) {
        this.data = BaseResponse.fromJsonList(data.data);
      } else {
        this.data = BaseResponse.fromString(data.data);
      }
    }
  }

  @override
  String toString() {
    return 'DataResult{data: $data, success: $success}';
  }
}
