import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/mydialog.dart';

class DiaLogUtil {
  // final BuildContext context;
  // final Colors colors;
  // final String desc;
  // const DiaLogUtil(
  //     {required this.context, required this.colors, required this.desc});

  static void show(BuildContext context, Color colors, String desc) {
    showDialog(
        context: context,
        barrierColor: colors, //背景透明
        barrierDismissible: false, // 屏蔽点击对话框外部自动关闭
        builder: (BuildContext context) {
          return MyDialog(desc);
        });
  }

  static void disMiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
