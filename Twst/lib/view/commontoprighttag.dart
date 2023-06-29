import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/service/constans.dart';

class CommonTopRightTag extends StatelessWidget {
  final String tag;
  final double size;
  const CommonTopRightTag({Key? key, required this.tag, required this.size});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (tag == Constants.HAS_FINISHED || tag == Constants.FINISHED) {
      return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'images/finished.png',
            width: size,
            height: size,
          ));
    } else if (tag == Constants.HAS_CANAELED || tag == Constants.CANAELED) {
      return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'images/canceled.png',
            width: size,
            height: size,
          ));
    } else if (tag == Constants.HAS_PERMINTED || tag == Constants.PERMINTED) {
      return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'images/permited.png',
            width: size,
            height: size,
          ));
    } else if (tag == Constants.HAS_REJECTED || tag == Constants.REJECTED) {
      return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'images/reject.png',
            width: size,
            height: size,
          ));
    }else if(tag==Constants.WAIT_CHECK){
      return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'images/wait_check.jpg',
            width: size,
            height: size,
          ));

    }
      else {
      return Container(
        padding: const EdgeInsets.only(left: 12, right: 12,top: 3, bottom: 4),
        margin: EdgeInsets.only(top: 8,right: 8,bottom: 5),
        decoration: const BoxDecoration(
          color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            // gradient:
            //     LinearGradient(colors: <Color>[Colors.blue, Colors.black45])
        ),
        child: Text(
          tag,

          style: TextStyle(fontSize: TextSizeConfig.size16,color: Colors.white,letterSpacing: 5),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
