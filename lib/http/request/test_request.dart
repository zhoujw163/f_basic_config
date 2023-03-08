import 'base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.get;
  }

  @override
  bool needAuth() {
    return false;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'upai/test/test';
  }
}
