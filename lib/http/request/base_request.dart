// 定义 HTTP 请求方式的枚举
enum HttpMethod {
  get('GET'),
  post('POST'),
  delete('DELETE'),
  put('PUT'),
  patch('PATCH'),
  head('HEAD');

  final String method;
  const HttpMethod(this.method);
}

// 基础请求
abstract class BaseRequest {
  // curl -X GET 'https://api.devio.org/uapi/test/test?name=jack' -H 'accept: */*
  // curl -X GET 'https://api.devio.org/uapi/test/test/1

  late String pathParams;
  bool useHttps = true;

  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();
  String path();

  bool needLogin();
  bool needAuth();

  // 添加参数
  Map<String, String> params = {};
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 添加 header
  Map<String, String> header = {};
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

  // 拼接完整的 url
  String url() {
    Uri uri;
    String pathStr = path();
    // 拼接 path params
    if (pathStr.endsWith('/')) {
      pathStr = '$pathStr$pathParams';
    } else {
      pathStr = '$pathStr/$pathParams';
    }

    // http https 切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    // ignore: avoid_print
    print('url: ${uri.toString()}');

    return uri.toString();
  }
}
