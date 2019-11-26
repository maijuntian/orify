

class DataResult {
  var data;
  bool result;
  Function next;

  DataResult(this.data, this.result, {this.next});

  @override
  String toString() {
    return 'DataResult{data: $data, result: $result}';
  }


}
