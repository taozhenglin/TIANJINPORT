import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/service/telandsmsservice.dart';
import 'package:twst/tools/apptools.dart';
import 'package:twst/tools/datautil.dart';
import 'package:twst/tools/servicelocator.dart';
import 'package:twst/view/common_imagetext_item.dart';
import 'package:twst/view/common_menu_item.dart';
import 'package:twst/view/common_updown_text_item.dart';

import '../config/textsize.dart';
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
  late String phoneNum = "";
  late String _path = '';
  late String _version = '';
  late String textFont = Constants.REGULAR_SIZE;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade600,
        title: Text(
          Constants.PERSONAL_CENTER,
          style:
              TextStyle(fontSize: TextSizeConfig.size20, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Column(
        //整体上下布局
        children: [
          Expanded(
              child: Column(
            children: [
              //头部
              Container(
                // width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     // image: AssetImage("images/cosco_logo.jpg"),
                  //     fit: BoxFit.cover),

                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.blueGrey.shade600,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                //左右布局  左边图像 右边上下布局分别显示 姓名 职位/部门
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
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
                                  : Image.asset("images/cosco_logo.jpg",
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 40,
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
                              height: 15,
                            ),
                            Text(
                              udbm,
                              style: TextStyle(
                                fontSize: TextSizeConfig.size16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: CommonImageTextItem(
                            icon: Icons.email_rounded,
                            text: '1345967291@qq.com',
                            textcolor: Colors.black,
                            imagecolor: Colors.yellow.shade900,
                            imageSize: 16,
                            textSize: TextSizeConfig.size14,
                            onPressed: () {
                              const String email = '1345967291@qq.com';
                              _service.sendEmail(email);
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: CommonImageTextItem(
                            icon: Icons.phone,
                            imageSize: 16,
                            textcolor: Colors.black,
                            textSize: TextSizeConfig.size14,
                            text: phoneNum,
                            imagecolor: Colors.black,
                            onPressed: () {
                              // final String number = '15501198266';
                              _service.call(phoneNum);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                        countColor: Colors.yellow,
                        onPressed: () {
                          print('版本号');
                        },
                      ),
                      CommonUpDownTextItem(
                        text: Constants.WAIT_DO,
                        textSize: TextSizeConfig.size14,
                        textColor: Colors.black54,
                        count: "99",
                        countSize: TextSizeConfig.size18,
                        countColor: Colors.yellow,
                        onPressed: () {
                          print('待办');
                        },
                      ),
                      CommonUpDownTextItem(
                        text: '待办',
                        textSize: TextSizeConfig.size14,
                        textColor: Colors.black54,
                        count: "99",
                        countSize: TextSizeConfig.size18,
                        countColor: Colors.yellow,
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

                    // CommonMenuItem(
                    //   icon: "images/qiandao_yellow.png",
                    //   title: '签到',
                    //   onPressed: () {
                    //     print('签到');
                    //   },
                    //   flag: 0,
                    //   note: "",
                    //   color: Colors.pink,
                    // ),
                    CommonMenuItem(
                      icon: "images/history.png",
                      title: Constants.VERSION_HISTORY,
                      onPressed: () {
                        print('版本号');
                      },
                      flag: 0,
                      note: "1.0.0",
                      color: Colors.green,
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
                      note: textFont,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          )),
          // Spacer(),
//退出登录
          Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: new BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(colors: <Color>[
                Colors.blueGrey.shade600,
                Colors.blue,
              ]),
            ),
            height: 50,
            child: TextButton(
              onPressed: _loginOut,
              child: Text(
                Constants.LOGIN_OUT,
                style: TextStyle(
                    color: Colors.white, fontSize: TextSizeConfig.size20),
              ),
              // splashColor: Colors.green,
            ),
          ),

          // munuItem("版本号：", "1.0"),
          // munuItem("我的待办：", "99"),
        ],
      ),
    );
  }

  void _loginOut() {
    // ToastUtils.shotToast('退出登录‘’‘’‘’‘’‘');
    Navigator.pushNamed(context, '/login');
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
        Text(number, style: TextStyle(fontSize: 25, color: Colors.blue)),
        Text(text, style: TextStyle(color: Colors.black54)),
      ]),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40))),
      onPressed: () {},
    );
  }

  Widget buildBottomSheetWidget() {
    String resultMessage = '';
    //弹框中内容  310 的调试
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
                "取消",
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
                  textFont = Constants.SMALL_SIZE;
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
                  textFont = Constants.REGULAR_SIZE;
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
                  textFont = Constants.LARGE_SIZE;
                  Navigator.of(context).pop();
                });
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
                setState(() {
                  TextSizeConfig.size8 = 12.0;
                  TextSizeConfig.size14 = 18.0;
                  TextSizeConfig.size16 = 20.0;
                  TextSizeConfig.size18 = 22.0;
                  TextSizeConfig.size20 = 24.0;
                  textFont = Constants.BIGEST_SIZE;
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
  }
}