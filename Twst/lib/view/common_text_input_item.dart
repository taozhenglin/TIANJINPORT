import 'dart:ffi';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/textsize.dart';
import '../service/constans.dart';
import '../tools/keybord.dart';
import '../tools/logutils.dart';
import 'numchangedwidget.dart';

class CommonTextInputForm extends StatelessWidget {
  final int flag;
  final String title;
  final Color titlecolor;
  final double titleSize;
  final String content;
  final String hint;
  final Color? imageColor;
  final TextInputType? keyBoardtype;
  final Function(String str)? callback;
  final FontWeight? weight;
  final String? maxvalue;
  final double? imageSize;
  final String? statue1;
  final String? statue2;
  final String? from;

  const CommonTextInputForm(
      {Key? key, required this.title,
      required this.titlecolor,
      required this.titleSize,
      this.callback,
      this.weight,
      required this.content,
      this.imageSize,
      this.imageColor,
      this.keyBoardtype,
      required this.hint,
        this.maxvalue,
        required this.flag,  this.statue1,  this.statue2, this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = content;

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
              onSubmitted: (value){
                callback?.call(value);
              },
              keyboardType: keyBoardtype,
              style: TextStyle(),
              textAlign: TextAlign.center,
              maxLines: 1,
              minLines: 1,
              controller: controller,
              onChanged: (value){
                if(flag==1){
                  //如果设置了最大值
                  if(maxvalue!=null&&num.parse(maxvalue!)>0){
                    //如果输入值大于最大值 则直接强制赋值为最大值
                    if(num.parse(value)>num.parse(maxvalue!)){
                      controller.text=maxvalue!;
                    }
                  }
                }


              },
              decoration: InputDecoration(
                // errorText: '注意：提交数量不得大于可用数量',

                labelText: flag==1 ? '最大可用数量： ${maxvalue}':'',
                labelStyle: TextStyle(color: Colors.red,fontSize: TextSizeConfig.size12),
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(10),
                hintStyle: TextStyle(fontSize: TextSizeConfig.size10),
                hintText: hint,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
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
              onTap: () {
                callback?.call(controller.text.toString());
                KeyBordUtil.hidekeybord(context);
              },
              child: Image.asset(
                "images/commit.png",
                width: imageSize,
                height: imageSize,
                color: imageColor,
              ),
              // child: Image.asset("images/commit.png",width: 25,height: 25,color: Colors.blueAccent,),
            ),
          ),
          if(flag==1)
          NumChangeWidget(
            from: from,
            onValueChanged: ( String value) {
            LogD('value=${value}');
            controller.text=value.toString();
            callback?.call(controller.text.toString());
          }, no: maxvalue!,
          dec:NumUtil.subtractDecStr(controller.text.toString(), '0'),
            statue1:statue1,
              statue2:statue2,
          ),
        ],
      ),
    );
  }
}


