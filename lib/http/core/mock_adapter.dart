// 测试适配器，mock数据
import 'package:f_basic_config/http/core/n_net_adapter.dart';
import 'package:f_basic_config/http/request/base_request.dart';

class MockAdapter extends NNetAdapter {
  @override
  Future<NNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return NNetResponse(
          data: {'code': 0, 'message': 'success'} as T,
          request: request,
          statusCode: 403);
    });
  }
}
