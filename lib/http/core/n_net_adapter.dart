import 'dart:convert';
import 'package:f_basic_config/http/request/base_request.dart';

// 网络请求抽象类
abstract class NNetAdapter {
  Future<NNetResponse<T>> send<T>(BaseRequest request);
}

// 统一网络层返回格式
class NNetResponse<T> {
  T? data;
  BaseRequest request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  NNetResponse(
      {this.data,
      required this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
