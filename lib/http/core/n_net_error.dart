// 需要登录异常
// 需要授权异常
class NeedLogin extends NNetError {
  NeedLogin({int code = 401, String message = '请先登录'}) : super(code, message);
}

class NeedAuth extends NNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

// 网络异常统一格式类
class NNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  NNetError(this.code, this.message, {this.data});
}
