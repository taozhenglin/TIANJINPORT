import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';

/// 横向菜单栏 图标+文字+右侧图标+点击事件
class CommonMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final int flag;
  final String note;
  final Color color;
  final String icon;

  const CommonMenuItem({
    required this.title,
    required this.onPressed,
    required this.flag,
    required this.note,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 8.0,
                right: 20.0,
                bottom: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: Image.asset(
                      icon,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontSize: TextSizeConfig.size16),
                  )),
                  if (flag == 1)
                    Text(
                      note,
                      style: TextStyle(fontSize: TextSizeConfig.size14),
                    ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  )
                ],
              )),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
