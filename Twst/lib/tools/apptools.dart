import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:package_info/package_info.dart';

import 'logutils.dart';

class AppInfoUtils {
  static late String _appName;
  static late String _packageName;
  static late String _version;
  static late String _buildNumber;

  static Future<String> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    LogD("_appName=" +
        _appName +
        "   _packageName=" +
        _packageName +
        "    _version=" +
        _version);
    return _appName + _packageName + _version + _buildNumber;
  }

  static Future<String> getAppNme() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;

    LogD("_appName=" + _appName);
    return _appName;
  }

  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageName = packageInfo.packageName;

    LogD("  _packageName=" + _packageName);
    return _packageName;
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    LogD("_version=" + _version);
    return _version;
  }
  //是否支持桌面图标消息小红点
  static Future<bool> isSupportBadge() async {
    //1判断是否支持
    bool isSupport = await FlutterAppBadger.isAppBadgeSupported();
    return isSupport;
  }

  static Future<String> getDeviceType() async {
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    String model;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
      LogD('model==${model}');
      return model;
    } else {
      //如果需要判断ios的具体机型还需作进一步判断
      //  iosInfo = await deviceInfo.iosInfo;
      // model=iosInfo.model;
      return 'IOS';
    }
  }
}
