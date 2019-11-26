import '../../entity_factory.dart';

class BaseResponse<T> {
  int code;
  String message;
  String dataStr;
  Map<String, dynamic> data;
  List<dynamic> dataList;

  T dataObj;
  List<T> dataListObj;

  BaseResponse({this.code, this.message, this.data, this.dataList});

  /// 处理results为String的情况
  BaseResponse.fromString(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    dataStr = json['data'];
  }

  /// 处理results为对象的情况
  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  /// 处理results为数组的情况
  BaseResponse.fromJsonList(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    dataList = json['data'];
  }

  /// 获取results字符串
  String getString() {
    return dataStr;
  }

  /// 获取results对象
  T getObject() {
    if (dataObj == null) dataObj = EntityFactory.generateOBJ<T>(data);
    return dataObj; //使用EntityFactory解析对象
  }

  /// 获取results数组
  List<T> getList() {
    if (dataListObj == null) {
      dataListObj = new List<T>();
      if (dataList != null) {
        dataList.forEach((v) {
          //拼装List
          dataListObj
              .add(EntityFactory.generateOBJ<T>(v)); //使用EntityFactory解析对象
        });
      }
    }
    return dataListObj;
  }

  @override
  String toString() {
    return 'BaseResponse{code: $code, message: $message, data: $data, dataList: $dataList}';
  }
}
