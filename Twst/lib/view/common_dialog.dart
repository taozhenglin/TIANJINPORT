import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/service/constans.dart';

class CommonDialog extends StatelessWidget{
   final VoidCallback onPressed;
const CommonDialog({
  required this.onPressed,
});
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))      ),
      child: AlertDialog(
        title:  Center(child: Text(Constants.WARM,style: TextStyle(fontSize: TextSizeConfig.size20,fontWeight: FontWeight.bold))),
        content:  Center(heightFactor: 1, child: Text("确定删除吗？",style: TextStyle(fontSize: TextSizeConfig.size16))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop("no");
            },
            child: Text(Constants.CANAELED,style: TextStyle(fontSize: TextSizeConfig.size16),),
          ),

            TextButton(
              onPressed: onPressed,
              child: Text(Constants.CONFIRM,style: TextStyle(fontSize: TextSizeConfig.size16)),
            ),

        ],
      ),
    );
  }

}