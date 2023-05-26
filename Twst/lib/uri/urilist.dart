// ignore_for_file: constant_identifier_names

import 'package:twst/service/constans.dart';

class UriList {
//测试环境 cosco
//   static const String BASE_URL_TEST =
//       "http://221.234.36.39:7006/meaweb/services/EAMMOBILE";
//测试环境 tianjin
  static const String BASE_URL_TEST =
      "http://221.234.36.39:7002/meaweb/services/EAMMOBILE";
//正式环境
  static const String BASE_URL_ONLINE =
      "https://cspeam.coscoshipping.com/meaweb/services/EAMMOBILE";

  static String getUrl() {
    if (Constants.ISDEBUG) {
      return BASE_URL_TEST;
    } else {
      return BASE_URL_ONLINE;
    }
  }
}
