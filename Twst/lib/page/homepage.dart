import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/page/personal.dart';

import '../bean/eventbus.dart';
import '../tools/datautil.dart';
import 'menupage.dart';
import 'msg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  late bool visiable = true;
  final pages = [MenuPage(), MsgPage(), PersonPage()];
  String mCount = '';
  getCount() async {
    String count = await DataUtils.getString('dbnum');
    if (count.isNotEmpty) {
      setState(() {
        if (int.parse(count) > 99) {
          mCount = "99+";
        } else {
          mCount = count;
        }
      });
    } else {
      setState(() {
        mCount = '0';
      });
    }

    return mCount;
  }

  var currentIndex = 0;
  var listen;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey, //主要用于设置item及字体颜色
        selectedItemColor: Colors.red, //主要用于设置item及字体颜色
        unselectedFontSize: TextSizeConfig.size16,
        selectedFontSize: TextSizeConfig.size18,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedIconTheme: IconThemeData(color: Colors.red),
        // showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.home),
            label: ('主页'),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.lightGreen,
              label: ('待办'),
              icon: Stack(
                children: [
                  const Icon(Icons.message),
                  if (mCount.isNotEmpty && mCount != "0")
                    Positioned(
                        // top: -5.0,
                        right: -1,
                        child: Offstage(
                          offstage: false,
                          child: Container(
                            alignment: Alignment.center,
                            // width: 18,
                            // height: 18,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 2, top: 0, right: 2, bottom: 0),
                              child: Text(
                                mCount,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSizeConfig.size8,
                                ),
                              ),
                            ),
                          ),
                        ))
                ],
              )),
          const BottomNavigationBarItem(
              backgroundColor: Colors.lightGreen,
              icon: Icon(Icons.person),
              label: ('我的')),
        ],
        onTap: (index) {
          _changeIndex(index);
        },
      ),
      body: pages[currentIndex],
    );
  }

  void _changeIndex(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCount();
    listen = eventBus.on<EventB>().listen((event) {
      print("接受到待办${event.obj}");
      if (event.obj.isNotEmpty) {
        setState(() {
          // if (event.obj == "0") {
          //   mCount = "0";
          // } else {
          //   visiable = true;
          // }
          if (int.parse(event.obj) > 99) {
            mCount = "99+";
          } else {
            mCount = event.obj;
          }
          // mCount = event.obj;
          print("mCount==${mCount}");
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listen.cancel();
  }
}
