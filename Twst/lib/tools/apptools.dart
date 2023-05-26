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
}
