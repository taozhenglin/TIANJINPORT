import 'package:decimal/decimal.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/tools/logutils.dart';

import '../service/constans.dart';

class NumChangeWidget extends StatefulWidget {

  final double height;
  String no;
  final ValueChanged<String> onValueChanged;
  Decimal dec;
  String? statue1;
  String? statue2;
  String? from;
  NumChangeWidget({ Key? key, this.height = 36.0, required this.no,  required this.onValueChanged, required this. dec, this.statue1,this.statue2,this.from}) : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<NumChangeWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _minusNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child: Icon(Icons.exposure_minus_1), // 设计图
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          Container(
            width: 62.0,
            alignment: Alignment.center,
            child: Text(widget.dec.toString(), maxLines: 1, style: TextStyle(fontSize: 20.0, color: Colors.black),),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: _addNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child: Icon(Icons.plus_one), // 设计图
            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    LogD('widget.dec=${widget.dec}');
    LogD('widget.statue1=${widget.statue1}');
    LogD('widget.statue2=${widget.statue2}');
    if(widget.from=="borrow"){
      //主表新建/驳回
      if (widget.statue1 == Constants.ADD_NEW_ONE|| widget.statue1 == Constants.REJECTED) {
        //子表 等待检查
        if (widget.statue2 == Constants.WAIT_CHECK) {
          if (num.parse(widget.dec.toString()) < 1) {
            return;
          }
          setState(() {
            widget.dec = NumUtil.subtractDecStr(widget.dec.toString(), "1");
            // LogD('subtractDecStr=${subtractDecStr}');
            // widget.no -= 1;

            if (widget.onValueChanged != null) {
              widget.onValueChanged(widget.dec.toString());
            }
          });
        }else{
          EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
          return;
        }
      }else{
        EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
        return;

      }
    }else{
      //主表待归还/部分归还/驳回
      if (widget.statue1 == Constants.WAIT_TO_BACK||widget.statue1 == Constants.PART_OF_BACK|| widget.statue1 == Constants.REJECTED) {
        //子表等待检查
        if (widget.statue2 == Constants.WAIT_CHECK) {
          if (num.parse(widget.dec.toString()) < 1) {
            return;
          }
          setState(() {
            widget.dec = NumUtil.subtractDecStr(widget.dec.toString(), "1");
            // LogD('subtractDecStr=${subtractDecStr}');
            // widget.no -= 1;

            if (widget.onValueChanged != null) {
              widget.onValueChanged(widget.dec.toString());
            }
          });

        }else{
          EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
          return;
        }
      }else{
        EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
        return;

      }
    }



    // var add = NumUtil.add(num.parse("2.0"), num.parse(widget.no));
    // var add2=  NumUtil.addDecStr("2.0",widget.no);
    // LogD('add2=${add2}');

  }

  void _addNum() {
    LogD('widget.dec=${widget.dec}');
    if(widget.from=="borrow"){
      //主表新建/驳回
      if (widget.statue1 == Constants.ADD_NEW_ONE|| widget.statue1 == Constants.REJECTED) {
        //子表 等待检查
        if (widget.statue2 == Constants.WAIT_CHECK) {
          if(num.parse(widget.dec.toString())>=num.parse(widget.no.toString())){
            return;
          }
          if(num.parse(widget.dec.toString())+1>num.parse(widget.no.toString())){
            return;
          }
          setState(() {
            widget.dec = NumUtil.addDecStr(widget.dec.toString(), "1");

            if (widget.onValueChanged != null) {
              widget.onValueChanged(widget.dec.toString());
            }
          });
        }else{
          EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
          return;

        }}else{
        EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
        return;
      }
    }else{
      //主表待归还/部分归还/驳回
      if (widget.statue1 == Constants.WAIT_TO_BACK||widget.statue1 == Constants.PART_OF_BACK|| widget.statue1 == Constants.REJECTED) {
        //子表等待检查
        if (widget.statue2 == Constants.WAIT_CHECK) {
          if(num.parse(widget.dec.toString())>=num.parse(widget.no.toString())){
            return;
          }
          if(num.parse(widget.dec.toString())+1>num.parse(widget.no.toString())){
            return;
          }
          setState(() {
            widget.dec = NumUtil.addDecStr(widget.dec.toString(), "1");

            if (widget.onValueChanged != null) {
              widget.onValueChanged(widget.dec.toString());
            }
          });

        }else{
          EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
          return;
        }
      }else{
        EasyLoading.showInfo(Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
        return;

      }
    }


  }
}