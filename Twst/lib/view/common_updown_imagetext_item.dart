import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 小图标+文字 item
class CommonUpDownImageTextItem extends StatelessWidget {
  IconData? icon;
  String? image;
  final String text;
  final Color imagecolor;
  final VoidCallback onPressed;
  final double imageSize;
  final double textSize;

  CommonUpDownImageTextItem({
    this.icon,
    this.image,
    required this.text,
    required this.imagecolor,
    required this.onPressed,
    required this.textSize,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Column(
          //所有的子Widget 水平方向居中
          mainAxisAlignment: MainAxisAlignment.center,
          // //所有的子Widget 竖直方向居中
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image!,
              width: imageSize,
              height: imageSize,
              color: imagecolor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: textSize),
            ),
          ],
        ),
      ),
    );
  }
}
