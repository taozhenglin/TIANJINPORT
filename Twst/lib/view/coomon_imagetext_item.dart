import 'dart:core';

import 'package:flutter/cupertino.dart';

class CommonImageTextItem extends StatelessWidget {
  final String asserts;
  final String text;
  final Color textcolor;
  final Color imagecolor;
  final VoidCallback onPressed;
  final double imageSize;
  final double textSize;
  final position;

  const CommonImageTextItem(
      {required this.asserts,
      required this.text,
      required this.textcolor,
      required this.imagecolor,
      required this.onPressed,
      required this.textSize,
      required this.imageSize,
      this.position});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
              //所有的子Widget 水平方向居中
              //mainAxisAlignment: position??MainAxisAlignment.start,
            //所有的子Widget 竖直方向居中
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                asserts,
                width: imageSize,
                height: imageSize,
                color: imagecolor,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(text,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: textSize,
                  ),
                  textAlign: TextAlign.center),
            ],
          )),
    );
  }
}
