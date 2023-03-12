// Dio adapter
import 'package:dio/dio.dart';
import 'package:f_basic_config/http/core/n_net_adapter.dart';

import '../request/base_request.dart';
import 'n_net_error.dart';

class DioAdapter extends NNetAdapter {
  @override
  Future<NNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    DioError? error;
    try {
      if (request.httpMethod() == HttpMethod.get) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.post) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.put) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.delete) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw NNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }

    return buildRes(response, request);
  }

  // 构建 NNetResponse
  Future<NNetResponse<T>> buildRes<T>(Response? response, BaseRequest request) {
    return Future.value(NNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
