// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  /// 根据key存储int类型
  static Future<void> setInt(String key, int value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setInt(key, value);
  }

  /// 根据key获取int类型
  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getInt(key) ?? defaultValue;
  }

  /// 根据key存储double类型
  static Future<void> setDouble(String key, double value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setDouble(key, value);
  }

  /// 根据key获取double类型
  static Future<double> getDouble(String key,
      {double defaultValue = 0.0}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    return _preferences.getDouble(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型
  static Future<void> setString(String key, String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(key, value);
  }

  /// 根据key获取字符串类型
  static Future<String> getString(String key,
      {String defaultValue = ""}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(key) ?? defaultValue;
  }

  /// 根据key存储布尔类型
  static Future<void> setBool(String key, bool value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(key, value);
  }

  /// 根据key获取布尔类型
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型数组
  static Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setStringList(key, value);
  }

  /// 根据key获取字符串类型数组
  static Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getStringList(key) ?? defaultValue;
  }

  /// 根据key存储Map类型
  static Future<void> setMap(String key, Map value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setString(key, json.encode(value));
  }

  /// 根据key获取Map类型
  static Future<Map<String, dynamic>> getMap(String key) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    String jsonStr = _preferences.getString(key) ?? "";
    Map<String, dynamic> map = json.decode(jsonStr);
    return map;
  }
}
