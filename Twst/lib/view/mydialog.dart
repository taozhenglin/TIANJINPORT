import 'package:flutter/material.dart';

class MyDialog extends Dialog {
  final String title;

  const MyDialog(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      //创建透明层
      child: Material(
        type: MaterialType.transparency, //透明类型
        child: SizedBox(
          width: 120,
          height: 120,
          child: Container(
            decoration: const ShapeDecoration(
                color: Colors.black45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
