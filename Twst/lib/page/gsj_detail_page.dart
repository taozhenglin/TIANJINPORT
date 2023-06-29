import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/view/commontextform.dart';
import 'package:twst/view/coomon_imagetext_item.dart';

import '../bean/eventbus.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/logutils.dart';
import '../view/common_menu_item.dart';
import 'chooserecievebylistpage.dart';

class GsjDetailPage extends StatefulWidget {
  final arguments;

  const GsjDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GsjDetailPageState();
  }
}

class GsjDetailPageState extends State<GsjDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  List<Map> list = [];
  late String desc; //描述
  late String store = ''; //仓库
  late String receiveby = ''; //领用人
  late String receivetime = ''; //领用时间
  late String sendtime = ''; //发放时间
  late String udzydd = ''; //作业地点
  late String udzyhl = ''; //分类
  late String createdby = ''; //创建人
  late String createdtime = ''; //创建时间
  late String sitedec = ''; //地点
  late String sendby = ''; //发放人
  late String cost = ''; //成本
  late String usedtype = ""; //使用情况
  TextEditingController descController = TextEditingController();
  TextEditingController _uPwdController = TextEditingController();
  late String name;
  late String displyName;
  var listen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogD('arguments==${widget.arguments}');
    listen = eventBus.on<EventA>().listen((event) {
      print("接受到关闭页面${event.str}");
      if (event.str.isNotEmpty) {
        if (event.str == Constants.CLOSE_PAGE) {
          Navigator.of(context).pop();
        }
      }
    });
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
      child: Column(
        children: [
          //系统单号
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextForm(
                    title: Constants.SYSTEM_NO,
                    titlecolor: Colors.black,
                    titleSize: TextSizeConfig.size16,
                    content: widget.arguments['num'],
                    contentcolor: Colors.black,
                    contentSize: TextSizeConfig.size16,
                    weight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 5, right: 12, bottom: 5),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    widget.arguments['status'],
                    style: TextStyle(
                        fontSize: TextSizeConfig.size16, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          //创建人
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonTextForm(
                title: Constants.CREATED_BY,
                titlecolor: Colors.black,
                titleSize: TextSizeConfig.size16,
                content: createdby,
                contentcolor: Colors.black,
                contentSize: TextSizeConfig.size16),
          ),
          //创建部门
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonTextForm(
                title: Constants.CREATED_DEPT,
                titlecolor: Colors.black,
                titleSize: TextSizeConfig.size16,
                content: widget.arguments["dept"],
                contentcolor: Colors.black,
                contentSize: TextSizeConfig.size16),
          ),
          //创建日期
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonTextForm(
                title: Constants.CREATED_TIME,
                titlecolor: Colors.black,
                titleSize: TextSizeConfig.size16,
                content: createdtime,
                contentcolor: Colors.black,
                contentSize: TextSizeConfig.size16),
          ),
          //地点
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonTextForm(
                title: Constants.LOCATION,
                titlecolor: Colors.black,
                titleSize: TextSizeConfig.size16,
                content: sitedec,
                contentcolor: Colors.black,
                contentSize: TextSizeConfig.size16),
          ),
          //成本总价
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonTextForm(
                title: Constants.COST_PRICE,
                titlecolor: Colors.black,
                titleSize: TextSizeConfig.size16,
                content: widget.arguments['udcbzj'],
                contentcolor: Colors.black,
                contentSize: TextSizeConfig.size16),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: CommonImageTextItem(
                asserts: "images/must_fill.png",
                text: '工属具借用归还说明:',
                textcolor: Colors.black,
                imagecolor: Colors.red,
                onPressed: () {},
                textSize: TextSizeConfig.size16,
                imageSize: TextSizeConfig.size25),
          ),
          //描述
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: TextField(
                    maxLength: 300,
                    maxLines: 4,
                    minLines: 1,
                    controller: descController,
                    decoration: InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      labelText: '点击右侧按钮提交',
                      labelStyle: TextStyle(color: Colors.greenAccent),
                      contentPadding: EdgeInsets.all(15),
                      hintStyle: TextStyle(fontSize: TextSizeConfig.size14),
                      hintText: Constants.PLEASE_INPUT,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                width: 25,
                child: InkWell(
                  child: Image.asset(
                    "images/commit.png",
                    width: 25,
                    height: 25,
                    color: Colors.blueAccent,
                  ),
                  onTap: () {
                    if (widget.arguments['status'] == Constants.ADD_NEW_ONE ||
                        widget.arguments['status'] == Constants.REJECTED) {
                      commit(
                          description: descController.text,
                          fromstoreloc: "",
                          recipient: "",
                          recipientdate: "",
                          udissueddate: "",
                          udzydd: "",
                          udzyhl: "");
                    } else
                      EasyLoading.showError(
                          Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                    return;
                  },
                ),
              )
            ],
          ),
//仓库
          CommonMenuItem(
            icon: "images/must_fill.png",
            title: Constants.STOREHOUSE,
            onPressed: () async {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChooseRecieveByListPage(tag: 'store')));
              LogD('result=${result}');
              setState(() {
                store = result['DESCRIPTION'];
              });

              commit(
                  description: "",
                  fromstoreloc: result['LOCATION'],
                  recipient: "",
                  recipientdate: "",
                  udissueddate: "",
                  udzydd: "",
                  udzyhl: "");
            },
            flag: 1,
            note: store,
            // color: Colors.red,
          ),
          //领用人
          CommonMenuItem(
            icon: "images/person.png",
            title: Constants.RECIEVE_BY,
            onPressed: () async {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChooseRecieveByListPage(tag: 'recieve')));
              LogD('result=${result}');
              setState(() {
                receiveby = result['DISPLAYNAME'];
              });

              commit(
                  description: "",
                  fromstoreloc: "",
                  recipient: result['PERSONID'],
                  recipientdate: "",
                  udissueddate: "",
                  udzydd: "",
                  udzyhl: "");
            },
            flag: 1,
            note: receiveby,
            // color: Colors.red,
          ),
          //领用时间
          CommonMenuItem(
            icon: "images/calendar.png",
            title: Constants.RECIEVE_DATE,
            onPressed: () {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              Pickers.showDatePicker(context,
                  mode: DateMode.YMDHM,
                  suffix: Suffix(),
                  pickerStyle: PickerStyle(
                      cancelButton: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Constants.CANAELED,
                          style: TextStyle(
                              fontSize: TextSizeConfig.size16,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      commitButton: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Constants.CONFIRM,
                          style: TextStyle(
                              fontSize: TextSizeConfig.size16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      headDecoration: const BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      backgroundColor: Colors.white,
                      textColor: Colors.black87), onConfirm: (p) {
                LogD('返回${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}');

                setState(() {
                  receivetime =
                      '${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}';
                });

                commit(
                    description: "",
                    fromstoreloc: "",
                    recipient: "",
                    recipientdate: receivetime,
                    udissueddate: "",
                    udzydd: "",
                    udzyhl: "");
              });
            },
            flag: 1,
            note: receivetime,
            // color: Colors.red,
          ),
          //发放时间
          CommonMenuItem(
            icon: "images/calendar.png",
            title: Constants.SEND_TO_DATE,
            onPressed: () {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              Pickers.showDatePicker(context,
                  mode: DateMode.YMDHM,
                  suffix: Suffix(),
                  pickerStyle: PickerStyle(
                      cancelButton: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Constants.CANAELED,
                          style: TextStyle(
                              fontSize: TextSizeConfig.size16,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      commitButton: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          Constants.CONFIRM,
                          style: TextStyle(
                              fontSize: TextSizeConfig.size16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      headDecoration: const BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      backgroundColor: Colors.white,
                      textColor: Colors.black87), onConfirm: (p) {
                LogD('返回${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}');
                setState(() {
                  sendtime =
                      '${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}';
                });
                commit(
                    description: "",
                    fromstoreloc: "",
                    recipient: "",
                    recipientdate: "",
                    udissueddate: sendtime,
                    udzydd: "",
                    udzyhl: "");
              });
            },
            flag: 1,
            note: sendtime,
            // color: Colors.red,
          ),
          //作业地点
          CommonMenuItem(
            icon: "images/location.png",
            title: Constants.WORK_LOCATION,
            onPressed: () {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Text('data');
                  },
                  context: this.context);
            },
            flag: 1,
            note: udzydd,
            // color: Colors.red,
          ),
          //作业货类
          CommonMenuItem(
            icon: "images/category.png",
            title: Constants.WORK_TYPE,
            onPressed: () {
              if (widget.arguments['status'] != Constants.ADD_NEW_ONE) {
                EasyLoading.showError(
                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                return;
              }
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Text('data');
                  },
                  context: this.context);
            },
            flag: 1,
            note: udzyhl,
            // color: Colors.red,
          ),
          // //作业货类
          // CommonMenuItem(
          //   icon: "images/category.png",
          //   title: Constants.USED_STATUE_TYPE,
          //   onPressed: () {
          //     showModalBottomSheet(
          //         backgroundColor: Colors.transparent,
          //         builder: (BuildContext context) {
          //           return Text('data');
          //         },
          //         context: this.context);
          //   },
          //   flag: 1,
          //   note: usedtype,
          //   // color: Colors.red,
          // ),
        ],
      ),
    );
  }

  Future<void> initData() async {
    //登陆手机号
    name = await DataUtils.getString("loginname");
    //展示中文名
    displyName = await DataUtils.getString("username");
    setState(() {
      desc = widget.arguments['desc'];
      descController.text = desc;
      store = widget.arguments['locdes'];
      receiveby = widget.arguments['recipient'];
      receivetime = widget.arguments['recipientdate'];
      sendtime = widget.arguments['udissueddate'];
      udzydd = widget.arguments['udzydd'];
      udzyhl = widget.arguments['udzyhl'];
      createdby = widget.arguments['udissuedby'];
      createdtime = widget.arguments['requesteddate'];
      sitedec = widget.arguments['sitedec'];
    });
  }

  Future<void> commit(
      {required String description,
      required String fromstoreloc,
      required String recipient,
      required String recipientdate,
      required String udissueddate,
      required String udzydd,
      required String udzyhl}) async {
    list.clear();
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.MODIFY;
    Map map = {
      "objectName": "UDINVUSE",
      "keyName": "UDINVUSENUM",
      "keyValue": widget.arguments['num'],
      if (description.isNotEmpty) "description": description,
      if (fromstoreloc.isNotEmpty) "FROMSTORELOC": fromstoreloc,
      if (recipient.isNotEmpty) "RECIPIENT": recipient,
      if (recipientdate.isNotEmpty) "RECIPIENTDATE": recipientdate,
      if (udissueddate.isNotEmpty) "UDISSUEDDATE": udissueddate,
      if (udzydd.isNotEmpty) "UDZYDD": udzydd,
      if (udzyhl.isNotEmpty) "UDZYHL": udzyhl
    };
    list.add(map);

    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost2('${name}', option, list);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        eventBus.fire(EventA(Constants.REFRESH_GSJ));
        if (fromstoreloc.isNotEmpty) {
          eventBus.fire(EventC(Constants.REFRESH_GSJ_LOCATION, fromstoreloc));
        }
      } else {
        EasyLoading.showToast(resultMap['msg']);
        // DiaLogUtil.disMiss(context);
      }
    } catch (e) {
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
    }
  }
}
