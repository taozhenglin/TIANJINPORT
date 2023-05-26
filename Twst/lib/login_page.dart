// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/net/httpconfig.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/service/dioclent.dart';
import 'package:twst/tools/datautil.dart';
import 'package:twst/tools/dialogutil.dart';
import 'package:twst/tools/logutils.dart';
// import 'package:twst/tools/toastutils.dart';
import 'package:twst/uri/urilist.dart';
import 'package:twst/view/common_imagetext_item.dart';
import 'package:twst/view/mydialog.dart';
import 'package:twst/view/notablepage.dart';

import 'bean/loginbean.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  String title = '';

  // ignore: prefer_final_fields
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _uPwdController = TextEditingController();
  bool _isObscure = true;
  final con = GlobalKey<ScaffoldState>();

  // final mContext = GlobalKey<ScaffoldState>();
  // _LoginPage();

  @override
  Widget build(BuildContext mContext) {
    // var args = ModalRoute.of(context)!.settings.arguments;

    // _uPwdController.text = " ";
    // _uPwdController.selection =
    //     TextSelection(baseOffset: 2, extentOffset: _uPwdController.text.length);

    // print("args==${args}");
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text(
        //     '这是一个新页面',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   // backgroundColor: Colors.transparent,
        //   leading: _leading(context),
        //   brightness: Brightness.dark,
        //   backgroundColor: Colors.white,
        //   primary: true,
        // ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              Text(title),
              // TextButton(
              //     onPressed: () => Navigator.pop(context, "我是点击按钮带回来的"),
              //     child: const Text('点我带值返回')),
              SizedBox(
                height: 45,
              ),
              // NotablePage(
              //     Text(
              //       '欢迎登录天津港移动客户端',
              //       style: TextStyle(color: Colors.greenAccent),
              //     ),
              //     200.0,
              //     new Duration(seconds: 2),
              //     200.0),
              ClipOval(
                child: Image.asset("images/app_bg.jpg",
                    height: 180, width: 180, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
                child: TextField(
                  controller: _uNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: TextSizeConfig.size16),
                      labelText: "用户名",
                      hintText: Constants.LOGIN_USERNAME_DESC,
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _uNameController.clear();
                          });
                        },
                      )),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
                child: TextField(
                  obscureText: _isObscure,
                  controller: _uPwdController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: TextSizeConfig.size16),
                      labelText: "密码",
                      hintText: Constants.LOGIN_PASSWORD_DESC,
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 100, top: 50, right: 0, bottom: 0),
                child: GestureDetector(
                  child: Text(
                    '1.0',
                    style: TextStyle(fontSize: TextSizeConfig.size14),
                  ),
                  onLongPress: () {
                    // con.currentState!.showBottomSheet(
                    //   (BuildContext context) => buildBottomSheetWidget(),
                    // );
                    print('点击长按');
                    // mContext.currentState!.showBottomSheet(build:(BuildContext con))
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return buildBottomSheetWidget();
                        },
                        context: this.context);
                  },
                ),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        colors: <Color>[Colors.red, Colors.blue])),
                child: TextButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shadowColor: Colors.lightGreen),
                    child: Text('登 录',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: TextSizeConfig.size20))),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    _uNameController.addListener(() {
      _printInput();
    });
    _uPwdController.addListener(() {
      _printInput();
    });
    initInput();
  }

  void login() async {
    Response response;
    String name = _uNameController.text;
    String pwd = _uPwdController.text;

    String option = Constants.LOGIN;
    Map json = {"passWord": _uPwdController.text.toString()};
    // var content = utf8.encode(jsonEncode(json));
    // var digest = base64Encode(content);
    if (name.isEmpty) {
      EasyLoading.showError(Constants.LOGIN_USERNAME_DESC);
      return;
    } else if (pwd.isEmpty) {
      EasyLoading.showError(Constants.LOGIN_PASSWORD_DESC);
      return;
    } else {
      // var request =
      //     "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:max=\"http://www.ibm.com/maximo\">\r\n" +
      //         "       <soapenv:Header/>\r\n" +
      //         "       <soapenv:Body>\r\n" +
      //         "          <max:eammobileWebServ creationDateTime=\"?\" baseLanguage=\"en\" transLanguage=\"zh\" messageID=\"?\" maximoVersion=\"?\">\r\n" +
      //         "             <max:userId>$name</max:userId>\r\n" +
      //         "             <max:langCode>ZH</max:langCode>\r\n" +
      //         "             <max:option>$option</max:option>\r\n" +
      //         "             <max:data>$digest</max:data>\r\n" +
      //         "          </max:eammobileWebServ>\r\n" +
      //         "       </soapenv:Body>\r\n" +
      //         "    </soapenv:Envelope>";
// 1 http请求
      // http.Response response = await http
      //     .post(Uri.parse(UriList.getUrl()),
      //         headers: {
      //           "Content-Type": "text/xml;charset=utf-8",
      //           "SOAPAction": "urn:action"
      //         },
      //         body: utf8.encode(request))
      //     .then((value) => value);
      // print(response.body.toString());
//2 Dio 请求
//       Dio dio = new Dio(HttpConfig.options);
      try {
        DiaLogUtil.show(context, Colors.black45, Constants.LOADING);
        Map<String, dynamic> resultMap =
            await DioClient.DioPost(name, option, json);
        if (resultMap['code'] == "1") {
          DataUtils.setString("username", resultMap['msg']['name']);
          DataUtils.setString("loginname", name);
          DataUtils.setString("pwd", pwd);
          DataUtils.setString("udbm", resultMap['msg']['udbm']);
          DataUtils.setString("dbnum", resultMap['msg']['dbnum']);
          DataUtils.setString("siteid", resultMap['msg']['siteid']);
          Navigator.pushReplacementNamed(context, '/homepage');
        } else {
          print("code==  0");
          // ToastUtils.shotToast(resultMap['msg']);
          DiaLogUtil.disMiss(context);
        }
      } catch (e) {
        LogE(e.toString());
        DiaLogUtil.disMiss(context);
      }

      // dio.options.headers = {
      //   "Content-Type": "text/xml;charset=utf-8",
      //   "SOAPAction": "urn:action"
      // };
      // Response response = await dio.post(
      //   UriList.getUrl(),
      //   data: request,
      // );
      // print("response==" + response.toString());
      // if (response.toString().contains("<return>") &&
      //     response.toString().contains("</return>")) {
      //   int start = response.toString().indexOf("<return>");
      //   int end = response.toString().indexOf("</return>");
      //   String substring = response.toString().substring(start + 8, end);
      //   print("substring==" + substring);
      //   var loginbean = await Loginbean.fromJson(jsonDecode(substring));
      //   if (loginbean.code == "1") {
      //     DataUtils.setString("username", loginbean.msg!.name);
      //     DataUtils.setString("pwd", pwd);
      //     ToastUtils.shotToast('登陆成功');
      //     Navigator.pushReplacementNamed(context, '/homepage');
      //   } else {
      //     ToastUtils.shotToast('用户名或密码错误，请重新输入');
      //   }
      // }
    }
  }

  void _printInput() {
    print(_uNameController.text.toString());
    print(_uPwdController.text.toString());
  }

  Widget _leading(BuildContext context) {
    return IconButton(
      onPressed: () => {Navigator.pop(context, "我是点击自定义返回键带回的")},
      icon: Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  Widget buildBottomSheetWidget() {
    String resultMessage = '';
    //弹框中内容  310 的调试
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
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
              onTap: () {
                setState(() {
                  resultMessage = "测试环境";
                  Constants.ISDEBUG = true;
                  print("Constants.ISDEBUG=${Constants.ISDEBUG}");
                  Navigator.of(context).pop();
                });
              },
              child: buildItem("测试环境", ""),
            ),
          ),
          //分割线
          Divider(),

          SizedBox(
            height: 50,
            child: InkWell(
              onTap: () {
                setState(() {
                  Constants.ISDEBUG = false;
                  print("Constants.ISDEBUG=${Constants.ISDEBUG}");
                  Navigator.of(context).pop();
                });
              },
              child: buildItem("正式环境", ""),
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
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child:
                  Text("取消", style: TextStyle(fontSize: TextSizeConfig.size14)),
              height: 44,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String title, String imagePath) {
    //添加点击事件
    return InkWell(
      child: Container(
        height: 40,
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
            Text(
              title,
              style: TextStyle(
                  color: Colors.blue, fontSize: TextSizeConfig.size14),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initInput() async {
    String name = await DataUtils.getString("loginname");
    if (name!.isNotEmpty) {
      _uNameController.text = name;
    }
    String pwd = await DataUtils.getString("pwd");
    if (pwd!.isNotEmpty) {
      _uPwdController.text = pwd;
    }
  }
}
