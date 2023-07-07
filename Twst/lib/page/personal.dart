import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/service/telandsmsservice.dart';
import 'package:twst/tools/apptools.dart';
import 'package:twst/tools/datautil.dart';
import 'package:twst/tools/servicelocator.dart';
import 'package:twst/view/common_icontext_item.dart';
import 'package:twst/view/common_menu_item.dart';
import 'package:twst/view/common_updown_text_item.dart';
import 'package:twst/view/marqueetext.dart';

import '../config/textsize.dart';
import '../main.dart';
import '../tools/colorutil.dart';
import '../tools/datautil.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonPageState();
  }
}

class _PersonPageState extends State {
  final TelAndSmsService _service = locator<TelAndSmsService>();

  late String username = '';
  late String udbm = "";
  late String udcount='';
  late String phoneNum = "";
  late String _path = '';
  late String _version = '';
  late String logintime='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.black87,
      //   title: Text(
      //     Constants.PERSONAL_CENTER,
      //     style:
      //         TextStyle(fontSize: TextSizeConfig.size20, color: Colors.white),
      //   ),
      //   elevation: 0,
      // ),
      body: Column(
        //整体上下布局
        children: [
          Expanded(
              child: Column(
            children: [
              //头部
                Stack(
                  children: [
                    // Image.asset('images/app_bg.webp',fit: BoxFit.cover,height: 190,),
                    Positioned(
                      child:  Container(
                        // width: double.infinity,
                        height: 190,
                        padding: const EdgeInsets.all(10),
                        decoration:  const BoxDecoration(
                          // image: DecorationImage(
                          //     // image: AssetImage("images/cosco_logo.jpg"),
                          //     fit: BoxFit.cover),

                          gradient: LinearGradient(colors: [
                            Colors.black87,
                            Colors.black54,
                            Colors.black26,
                          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        ),
                        //左右布局  左边图像 右边上下布局分别显示 姓名 职位/部门
                        child: Column(
                          children: [
                            const SizedBox(height: 40,),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return buildBottomSheetWidget();
                                        },
                                        context: this.context);
                                  },
                                  child: ClipOval(
                                      child: _path.isNotEmpty
                                          ? Image.file(File(_path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover)
                                          // :Icon(Icons.person,size: 100,color: Colors.grey,))
                                          : Image.asset("images/banner.jpg",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                //上下 名字 部门
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: TextSizeConfig.size20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          udbm,
                                          style: TextStyle(
                                            fontSize: TextSizeConfig.size16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        //电话号码
                                        CommonIconTextItem(
                                          icon: Icons.phone,
                                          imageSize: 16,
                                          textcolor: Colors.white,
                                          textSize: TextSizeConfig.size14,
                                          text: phoneNum,
                                          imagecolor: Colors.orange,
                                          onPressed: () {
                                            // final String number = '15501198266';
                                            _service.call(phoneNum);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            //电话号码
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   // crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     // Flexible(
                            //     //   flex: 1,
                            //     //   child: CommonIconTextItem(
                            //     //     icon: Icons.email_rounded,
                            //     //     text: '1345967291@qq.com',
                            //     //     textcolor: Colors.black,
                            //     //     imagecolor: Colors.yellow.shade900,
                            //     //     imageSize: 16,
                            //     //     textSize: TextSizeConfig.size14,
                            //     //     onPressed: () {
                            //     //       const String email = '1345967291@qq.com';
                            //     //       _service.sendEmail(email);
                            //     //     },
                            //     //   ),
                            //
                            //     CommonIconTextItem(
                            //       icon: Icons.phone,
                            //       imageSize: 16,
                            //       textcolor: Colors.white,
                            //       textSize: TextSizeConfig.size14,
                            //       text: phoneNum,
                            //       imagecolor: Colors.orange,
                            //       onPressed: () {
                            //         // final String number = '15501198266';
                            //         _service.call(phoneNum);
                            //       },
                            //     ),
                            //
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    )

                  ],

              ),

              // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 10),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonUpDownTextItem(
                        text: Constants.VERSION_CODE,
                        textSize: TextSizeConfig.size14,
                        textColor: Colors.black54,
                        count: _version,
                        countSize: TextSizeConfig.size18,
                        countColor: Colors.black,
                        onPressed: () {
                          print('版本号');

                        },
                      ),

                      CommonUpDownTextItem(
                        text: Constants.LOGIN_TIME,
                        textSize: TextSizeConfig.size14,
                        textColor: Colors.black54,
                        count: logintime,
                        countSize: TextSizeConfig.size18,
                        countColor: Colors.black,
                        onPressed: () {
                          print('待办');
                        },
                      ),

                      // CommonUpDownTextItem(
                      //   text: Constants.WAIT_DO,
                      //   textSize: TextSizeConfig.size14,
                      //   textColor: Colors.black54,
                      //   count: "99",
                      //   countSize: TextSizeConfig.size18,
                      //   countColor: Colors.yellow,
                      //   onPressed: () {
                      //     print('待办');
                      //   },
                      // ),
                      CommonUpDownTextItem(
                        text: '待办',
                        textSize: TextSizeConfig.size14,
                        textColor: Colors.black54,
                        count: '${udcount}',
                        countSize: TextSizeConfig.size18,
                        countColor: Colors.black,
                        onPressed: () {
                          print('待办');
                        },
                      )
                    ],
                  ),
                ),
              ),

              //菜单栏
              Container(
                color: Colors.white,
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    CommonMenuItem(
                      icon: "images/scan_gry.png",
                      title: Constants.SWEEP,
                      onPressed: () {
                        print('扫一扫');
                      },
                      flag: 0,
                      note: "",
                      color: Colors.black54,
                    ),
                    CommonMenuItem(
                      icon: "images/textfont.png",
                      title: Constants.TEXT_FONT_SIZE,
                      onPressed: () {
                        print('字体大小');
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return textSizeBottomSheetWidget();
                            },
                            context: this.context);
                      },
                      flag: 1,
                      note: Constants.REGULAR_SIZE,
                      color: Colors.orange,
                    ),
                    // CommonMenuItem(
                    //   icon: "images/history.png",
                    //   title: Constants.VERSION_HISTORY,
                    //   onPressed: () {
                    //     print('更新记录');
                    //   },
                    //   flag: 0,
                    //   note: "",
                    // ),


                    CommonMenuItem(
                      icon: "images/login_out.png",
                      title: Constants.LOGIN_OUT,
                      onPressed: () {
                        _loginOut();
                      },
                      flag: 0,
                      note: "",
                      color: Colors.red,
                    ),

                    // CommonMenuItem(
                    //   icon: "images/clean.png",
                    //   title: Constants.CLEAN_SP,
                    //   onPressed: _cleanCash,
                    //   flag: 0,
                    //   note: "",
                    //   color: Colors.redAccent,
                    // ),

                  ],
                ),
              ),
            ],
          )),
          // Spacer(),
//退出登录
//           Container(
//             margin: EdgeInsets.fromLTRB(0,0,0,20),
//             alignment: Alignment.center,
//             // width: 100,
//             // decoration:  const BoxDecoration(
//             //   color: Colors.grey,
//             //   borderRadius:  BorderRadius.all(Radius.circular(30)),
//             //   // gradient: LinearGradient(colors: <Color>[
//             //   //   Colors.black87,
//             //   //   Colors.black12,
//             //   // ]),
//             // ),
//             child:  TextButton(
//               onPressed: _loginOut,
//               child: Image.asset('images/login_out.png',width: 80,height: 80,),
//               // icon: Icon(Icons.login_rounded,size: 50,color: Colors.grey,),
//               // child: Text(
//               //   Constants.LOGIN_OUT,
//               //   style: TextStyle(
//               //       color: Colors.white, fontSize: TextSizeConfig.size20),
//               // ),
//               // splashColor: Colors.green,
//             ),
//           ),

        ],
      ),
    );
  }

  void _loginOut() {
    // ToastUtils.shotToast('退出登录‘’‘’‘’‘’‘');
    Navigator.pushNamed(context, '/login');
    // var context = gloableKey.currentState!.overlay!.context;
    // this.showCupertinoDialog(context);

  }

  Widget _leading(BuildContext context) {
    return IconButton(
      onPressed: () => {Navigator.pop(context, "我是点击自定义返回键带回的")},
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

// Widget munuItem(String tag, String version) {
//   return GestureDetector(
//       onTap: onPressed,
//       child: Row(
//         children: [Padding(padding: EdgeInsets.only(right: 8.0)), ch],
//       ));
// }
  @override
  void initState() {
    getInfo();
  }

  Widget _buildCard() {
    return Container(
      // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Card(
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNumberTextWidget('1.0.0', '版本'),
              _buildNumberTextWidget('99', '待办'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberTextWidget(String number, String text) {
    return TextButton(
      child: Column(children: [
        Text(number, style: const TextStyle(fontSize: 25, color: Colors.blue)),
        Text(text, style: const TextStyle(color: Colors.black54)),
      ]),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40))),
      onPressed: () {},
    );
  }

  Widget buildBottomSheetWidget() {
    String resultMessage = '';
    //弹框中内容  310 的调试
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                var file =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                DataUtils.setString(username, file!.path.toString());
                setState(() {
                  _path = file!.path.toString();
                  print("_path=${_path}");
                  // Map map = {"avatr": File(file.path).toString()};
                  // DataUtils.setMap("map", map);
                });
                Navigator.of(context).pop();
              },
              child: buildItem(Constants.TAKE_PHOTO, "", onTap: () {}),
            ),
          ),
          //分割线
          const Divider(
            height: 2,
            color: Colors.blue,
          ),

          SizedBox(
            height: 50,
            child: InkWell(
              onTap: () async {
                var file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                DataUtils.setString(username, file!.path.toString());
                setState(() {
                  _path = file!.path.toString();
                  print("_path=${_path}");
                  // Map map = {"avatr": File(file.path).toString()};
                  // DataUtils.setMap("map", map);
                });
                Navigator.of(context).pop();
              },
              child: buildItem("相册", "", onTap: () {}),
            ),
          ),
          //分割线
          const Divider(
            height: 2,
            color: Colors.blue,
          ),

          Container(
            color: Colors.white70,
            height: 8,
          ),
          //取消按钮
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Text(
                Constants.CANAELED,
                style: TextStyle(fontSize: TextSizeConfig.size14),
              ),
              height: 44,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget textSizeBottomSheetWidget() {
    String resultMessage = '';
    //弹框中内容
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            child: InkWell(
              onTap: () {
                setState(() {
                  TextSizeConfig.size8 = 6.0;
                  TextSizeConfig.size14 = 12.0;
                  TextSizeConfig.size16 = 14.0;
                  TextSizeConfig.size18 = 16.0;
                  TextSizeConfig.size20 = 18.0;
                  Constants.REGULAR_SIZE = Constants.SMALL_SIZE;
                  Navigator.of(context).pop();
                });
              },
              child: buildItem("小", "", onTap: () {}),
            ),
          ),
          //分割线
          Divider(),

          Container(
            height: 30,
            child: InkWell(
              onTap: () {
                setState(() {
                  TextSizeConfig.size8 = 8.0;
                  TextSizeConfig.size14 = 14.0;
                  TextSizeConfig.size16 = 16.0;
                  TextSizeConfig.size18 = 18.0;
                  TextSizeConfig.size20 = 20.0;
                  Constants.REGULAR_SIZE  = Constants.REGULAR_SIZE;
                  Navigator.of(context).pop();
                });
              },
              child: buildItem("常规", "", onTap: () {}),
            ),
          ),
          //分割线
          Divider(),

          Container(
            height: 30,
            child: InkWell(
              onTap: () {

                setState(() {
                  TextSizeConfig.size8 = 10.0;
                  TextSizeConfig.size14 = 16.0;
                  TextSizeConfig.size16 = 18.0;
                  TextSizeConfig.size18 = 20.0;
                  TextSizeConfig.size20 = 22.0;
                  Constants.REGULAR_SIZE  = Constants.LARGE_SIZE;
                }

                );
                Navigator.of(context).pop();

              },
              child: buildItem("大", "", onTap: () {}),
            ),
          ),
          //分割线
          Divider(),

          Container(
            height: 30,
            child: InkWell(
              onTap: () {
                EasyLoading.showInfo('超大字体可能会降低设备分辨率');
                setState(() {
                  TextSizeConfig.size8 = 12.0;
                  TextSizeConfig.size14 = 18.0;
                  TextSizeConfig.size16 = 20.0;
                  TextSizeConfig.size18 = 22.0;
                  TextSizeConfig.size20 = 24.0;
                  Constants.REGULAR_SIZE  = Constants.BIGEST_SIZE;
                  Navigator.of(context).pop();
                });
              },
              child: buildItem("超大", "", onTap: () {}),
            ),
          ),
          //分割线
          Divider(),

          Container(
            color: Colors.white70,
            height: 8,
          ),

          //取消按钮
          //添加个点击事件
          Container(
            height: 50,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Text(
                  "取消",
                  style: TextStyle(fontSize: TextSizeConfig.size14),
                ),
                height: 44,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String title, String imagePath, {required Function onTap}) {
    //添加点击事件
    return Container(
      height: 50,
      //左右排开的线性布局
      child: Row(
        //所有的子Widget 水平方向居中
        mainAxisAlignment: MainAxisAlignment.center,
        //所有的子Widget 竖直方向居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(
          //   imagePath,
          //   width: 25,
          //   height: 25,
          // ),
          // SizedBox(
          //   width: 10,
          // ),
          Center(
              child: Text(
            title,
            style:
                TextStyle(color: Colors.blue, fontSize: TextSizeConfig.size14),
          ))
        ],
      ),
    );
  }

  void getInfo() async {
    String name = await DataUtils.getString("username");
    print("name==${name}");
    setState(() {
      username = name;
    });
    String bm = await DataUtils.getString("udbm");
    print("bm==${bm}");
    setState(() {
      udbm = bm;
    });
    String count = await DataUtils.getString('taskcount');
    print("count==${count}");
    setState(() {
      udcount = count;
    });

    String phone = await DataUtils.getString("loginname");
    print("phone==${phone}");
    setState(() {
      phoneNum = phone;
    });

    String path = await DataUtils.getString(username);
    print("path=${path}");
    setState(() {
      _path = path;
    });

    String version = await AppInfoUtils.getAppVersion();
    print("version=${version}");
    setState(() {
      _version = version;
    });
    String time = await DataUtils.getString("logintime");
    print("time==${time}");
    setState(() {
      logintime = time;
    });

  }
  _cleanCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    EasyLoading.showSuccess(Constants.CASH_CLEANED);
    // 删除极光别名
    //jPush.deleteAlias().then((map) {});
  }

  void showCupertinoDialog(BuildContext context) {
    showDialog(
        context: context,
        // barrierColor: Color(0xFF1B1B1B),
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Image(
              image: AssetImage('images/login_out.png'),
              width: 40,
              height: 40,
            ),
            content: const Text(
              '\n您的账号在另一台设备上登录，\n您已被登出',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                textStyle:
                const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                child: Text('确定'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/login');
                  // 实现具体操作
                },
              ),
            ],
          );
        });
  }
}
