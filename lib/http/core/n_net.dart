import 'package:f_basic_config/http/request/base_request.dart';

class NNet {
  NNet._();
  static NNet? _instance;

  static NNet getInstance() {
    _instance ??= NNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    printLog(result);
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url: ${request.url}');
    printLog('url: ${request.httpMethod()}');
    request.addHeader('token', 123);
    printLog('url: ${request.header}');

    return Future.value({
      'statusCode': 200,
      'data': {'code': 0, 'message': 'success'}
    });
  }

  void printLog(v) {
    // ignore: avoid_print
    print('net: ${v.toString()}');
  }
}
