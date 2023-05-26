import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Test3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: const Text("一个组合布局"),
    //   ),
    //   body: ListView(
    //     children: [
    //       Image.asset(
    //         'images/girl.png',
    //         width: 600,
    //         height: 200,
    //         fit: BoxFit.cover,
    //       ),
    //       title(),
    //     ],
    //   ),
    // );
    return MaterialApp(
      title: "",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: ListView(
          children: [
            Image.asset(
              'images/girl.png',
              width: 600,
              height: 200,
              fit: BoxFit.cover,
            ),
            title(),
            buttom(context),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      //左右行
      child: Row(
        children: [
          //左侧文本
          Expanded(
              //上下 列
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: const Text(
                  'great minds think alike',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'yeah',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          )),
          //右侧图标
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('99')
        ],
      ),
    );
  }

  Widget buttomline(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buttom(BuildContext context) {
    return Container(
      child: Row(
        //横向 左右
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttomline(context, Icons.call, 'CALL'),
          buttomline(context, Icons.phone, 'PHONE'),
          buttomline(context, Icons.star, 'STAR'),
        ],
      ),
    );
  }
}
