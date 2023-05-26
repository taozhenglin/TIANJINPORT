import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/net/httpconfig.dart';
import 'package:twst/tools/networkutil.dart';
import 'package:twst/uri/urilist.dart';

import 'constans.dart';

class DioClient {
  static String _userName = "";
  late Dio _dio;
  static final DioClient _client = DioClient._internal();
  static late Map<String, dynamic> resultMap;

  factory DioClient() {
    return _client;
  }

  static DioClient get instance => DioClient._internal();

  DioClient._internal() {
    init();
  }

  Dio init() {
    _dio = Dio(HttpConfig.options);
    _dio.interceptors.add(interceptorsWrapper());
    return _dio;
  }

  static InterceptorsWrapper interceptorsWrapper() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      print(options.path);
      print(options.data);
      print(options.headers.toString());
      return handler.next(options); //continue
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      print("response==" + response.data);
      if (response.toString().contains("<return>") &&
          response.toString().contains("</return>")) {
        int start = response.toString().indexOf("<return>");
        int end = response.toString().indexOf("</return>");
        String substring = response.toString().substring(start + 8, end);
        print("substring==" + substring);
      } else {}
      // Do something with response data
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) {
      print("onError==" + e.message);
      if (e.message.contains('Connecting timed out')) {
        // ToastUtils.shotToast('网络连接超时');
      }

      // Do something with response error
      return handler.next(e); //continue
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    });
  }

  /**
   *  post 请求
   */
  static dynamic DioPost(String userName, String maxOption, Map mapJaon) async {
    var netWorkAvailable = await NetWorkUtil.isNetWorkAvailable();
    print(netWorkAvailable);
    if (netWorkAvailable == 0) {
      EasyLoading.showError('网络连接失败!');
      Constants.ISNETWORKAVAILABLE = false;
      return;
    } else {
      Constants.ISNETWORKAVAILABLE = true;
    }
    var content = jsonEncode(mapJaon);
    // var digest = base64Encode(content);
    // print("请求数据：$mapJaon");
    // print("请求加密数据：$digest");
    var request =
        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:max=\"http://www.ibm.com/maximo\">\r\n" +
            "       <soapenv:Header/>\r\n" +
            "       <soapenv:Body>\r\n" +
            "          <max:eammobileWebServ creationDateTime=\"?\" baseLanguage=\"en\" transLanguage=\"zh\" messageID=\"?\" maximoVersion=\"?\">\r\n" +
            "             <max:userId>$userName</max:userId>\r\n" +
            "             <max:langCode>ZH</max:langCode>\r\n" +
            "             <max:option>$maxOption</max:option>\r\n" +
            "             <max:data>$content</max:data>\r\n" +
            "          </max:eammobileWebServ>\r\n" +
            "       </soapenv:Body>\r\n" +
            "    </soapenv:Envelope>";
    // Response response =
    //     await DioClient._internal()._dio.post(UriList.getUrl(), data: request);
    Response response =
        await DioClient._internal()._dio.post(UriList.getUrl(), data: request);

    if (response.toString().contains("<return>") &&
        response.toString().contains("</return>")) {
      int start = response.toString().indexOf("<return>");
      int end = response.toString().indexOf("</return>");
      String substring = response.toString().substring(start + 8, end);
      resultMap = json.decode(substring);
    } else {}

    return resultMap;
  }
}
