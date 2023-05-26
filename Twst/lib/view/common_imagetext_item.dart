import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 小图标+文字 item
class CommonImageTextItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textcolor;
  final Color imagecolor;
  final VoidCallback onPressed;
  final double imageSize;
  final double textSize;

  const CommonImageTextItem({
    required this.icon,
    required this.text,
    required this.textcolor,
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
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
//所有的子Widget 水平方向居中
                mainAxisAlignment: MainAxisAlignment.end,
                //所有的子Widget 竖直方向居中
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: imageSize,
                    color: imagecolor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: TextStyle(color: textcolor, fontSize: textSize),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
