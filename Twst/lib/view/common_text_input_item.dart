

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/textsize.dart';
import '../service/constans.dart';

class CommonTextInputForm extends StatelessWidget {
  final String title;
  final Color titlecolor;
  final double titleSize;
  final String content;
  final String hint;
  final Color? imageColor;
  final Function(String str)? callback;
  final FontWeight? weight;
  final double? imageSize;

  const CommonTextInputForm({
    required this.title,
    required this.titlecolor,
    required this.titleSize,
    this.callback,
    this.weight,
    required this.content,
    this.imageSize,
    this.imageColor,
    required this.hint
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text=content;

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
            child: TextField(
              style: TextStyle(),
              textAlign:TextAlign.center,
              maxLines: 1,
              minLines: 1,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(10),
                hintStyle: TextStyle(fontSize: TextSizeConfig.size14),
                hintText: hint,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),



                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: (){
                callback?.call(controller.text.toString());
              },
              child: Image.asset("images/commit.png",width: imageSize,height: imageSize,color: imageColor,),
                // child: Image.asset("images/commit.png",width: 25,height: 25,color: Colors.blueAccent,),
            ),
          )
        ],
      ),
    );
  }
}
