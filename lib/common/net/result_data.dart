
/**
 * 网络结果数据
 * Created by mai
 * Date: 2018-07-16
 */
class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});

  @override
  String toString() {
    return 'ResultData{data: $data, result: $result, code: $code, headers: $headers}';
  }

}
