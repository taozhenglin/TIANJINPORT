import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';

class CommonSeachBar extends StatelessWidget {
  final String hint;
  final double hintSize;
  final Color hintColor;
  final IconData icon;
  final Function(String str)? onSearch;

  const CommonSeachBar({
    required this.hint,
    required this.hintSize,
    required this.hintColor,
    required this.icon,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    // TODO: implement build
    // margin: EdgeInsets.all(3),
    // decoration: BoxDecoration(
    //     border: Border.all(color: Colors.blue, width: 1),
    //     borderRadius: BorderRadius.all(Radius.circular(15))),
    child:
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: TextField(
        style: TextStyle(
            color: Colors.greenAccent, fontSize: TextSizeConfig.size14),
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: InputBorder.none,
            // labelText: "请输入",
            // labelStyle: TextStyle(fontSize: hintSize, wordSpacing: 5),
            hintText: hint,
            contentPadding:
                EdgeInsets.only(left: 20, top: 5, right: 10, bottom: 5),
            hintStyle: TextStyle(fontSize: hintSize, color: hintColor),
            suffixIcon: IconButton(
              icon: Icon(
                icon,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                onSearch?.call(controller.text.toString());
                // print(controller.text.toString());
              },
            )),
      ),
    );
  }
}
