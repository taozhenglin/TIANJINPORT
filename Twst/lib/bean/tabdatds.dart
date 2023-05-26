import 'package:flutter/cupertino.dart';

class TabData {
  /// 导航标题
  final String title;

  // 导航图标
  final IconData? icon;
  //路由跳转
  final String route;
  //自定义图标
  final String? image;

  final Widget? widget;

  /// 导航数据构造函数
  const TabData(
      {required this.title,
      this.icon,
      required this.route,
      this.image,
      this.widget});
}
