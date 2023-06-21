import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/textsize.dart';
import '../tools/hightutils.dart';

class CommonLightTextItem extends StatelessWidget{
  final String title;
  final Color titlecolor;
  final double titleSize;
  final String content;
  final Color contentcolor;
  final double contentSize;
  final String searchInput;
  final FontWeight? weight;

  const CommonLightTextItem({
    required this.title,
    required this.titlecolor,
    required this.titleSize,
    required this.content,
    required this.contentcolor,
    required this.contentSize,
    required this.searchInput,
    this.weight,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              color: titlecolor,
            ),
          ),
      Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: LightText(
            text: content,
            lightText: searchInput,
            textStyle: TextStyle(
                fontSize: titleSize,
                color: titlecolor,
                fontWeight: weight
            ),
            lightStyle: TextStyle(
              fontSize: contentSize,
              color: contentcolor,
            ),
          ),
        ),
      ),
        ],
      ),
    );
  }

}