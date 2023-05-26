import 'package:dio/dio.dart';
import 'package:twst/uri/urilist.dart';

class HttpConfig {
  static const connectTimeout = 5000;
  static const receiveTimeout = 3000;

  //基础配置
  static final options = BaseOptions(
      baseUrl: UriList.getUrl(),
      headers: {
        "Content-Type": "text/xml;charset=utf-8",
        "SOAPAction": "urn:action"
      },
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout);
}
