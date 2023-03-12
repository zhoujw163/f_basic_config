import '../request/base_request.dart';
import 'dio_adapter.dart';
import 'n_net_adapter.dart';
import 'n_net_error.dart';

class NNet {
  NNet._();
  static NNet? _instance;

  static NNet getInstance() {
    _instance ??= NNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    NNetResponse? response;
    // ignore: prefer_typing_uninitialized_variables
    var error;

    try {
      response = await send(request);
    } on NNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw NNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');

    // // 使用 mockAdapter
    // NNetAdapter adapter = MockAdapter();

    // 使用 dioAdapter
    NNetAdapter adapter = DioAdapter();

    return adapter.send(request);
  }

  void printLog(v) {
    // ignore: avoid_print
    print('net: ${v.toString()}');
  }
}
