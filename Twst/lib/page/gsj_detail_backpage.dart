
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/tools/keybord.dart';
import 'package:twst/tools/logutils.dart';

import '../base/baselist_fragment.dart';
import '../base/baselist_fragment_with_flb.dart';
import '../base/baselist_page.dart';
import '../bean/eventbus.dart';
import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/colorutil.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../view/common_dialog.dart';
import '../view/common_text_input_item.dart';
import '../view/commontextform.dart';
import '../view/commontoprighttag.dart';
import 'gsj_common_add_page.dart';

class GsjDetailBackPage extends BaseListFragmentWithFlb {
  final num;
  final location;
  final statue;

  GsjDetailBackPage(
      {Key? key, this.location, required this.num, required this.statue});

  @override
  BaseListFragmentWithFlbState createState() {
    // TODO: implement createState
    return GsjDetailBackPageState(num, location, statue);
  }
}

class GsjDetailBackPageState extends BaseListFragmentWithFlbState {
  List<Map> list = [];
  List agencyList = [];
  late String name;
  late String no='';
  late String location;
  late String statue;
  var listen;

  GsjDetailBackPageState(this.no, this.location, this.statue);

  @override
  void onRefresh() {
    // TODO: implement onRefresh
    super.onRefresh();
    getGsjList(true);
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
    super.onLoading();
    getGsjList(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogD('num=${no}');
    listen = eventBus.on<EventA>().listen((event) {
      print("接受到刷新${event.str}");
      if (event.str.isNotEmpty) {
        if (event.str == Constants.REFRESH_GSJ_BACK_LIST) {
          getGsjList(true);
        }
      }
    });
    listen = eventBus.on<EventC>().listen((event) {
      print("接受到刷新${event.str}");
      if (event.str.isNotEmpty) {
        if (event.str == Constants.REFRESH_GSJ_LOCATION) {
          setState(() {
            location = event.content;
          });
        }
      }
    });

    Future.delayed(const Duration(microseconds: 300), () {
      getGsjList(true);
    });
  }

  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
    name = await DataUtils.getString("loginname");
  }

  Future<void> getGsjList(bool isrefresh) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh} ');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map json = {
      "keyNum": Constants.GSJ_BORROW_BACK_LIST,
      "sqlWhere": " and UDINVUSENUM='${no}' and USETYPE='UDGH'",
      "sinorSearch": '',
      "keysearch": "keyValue:1",
      "startRow": startPage,
      "endRow": endPage
    };
    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost('${name}', option, json);
      if (resultMap['code'] == Constants.CODE_OK) {
        // DiaLogUtil.disMiss(context);
        Constants.ISNETWORKAVAILABLE = true;
        List _agencyList = resultMap['msg'];
        total = int.parse(resultMap['total']);
        DiaLogUtil.disMiss(context);
        if (mounted) {
          setState(() {
            if (total > 0) {
              //有数据
              finishRefresh(isrefresh);
              if (_agencyList.isNotEmpty) {
                noData = false;

                //下拉刷新
                if (isrefresh) {
                  agencyList = _agencyList;
                } else {
                  //上拉加载
                  agencyList.addAll(_agencyList);
                }
              } else {
                // ToastUtils.shotToast(Constants.NO_MORE_DATA);
                print("_agencyList.isEmpty");
                EasyLoading.showToast(Constants.NO_MORE_DATA);
                // refreshController.loadNoData();
              }
            } else {
              // ToastUtils.shotToast(Constants.NO_DATA);
              noData = true;
            }
          });
        }
      } else {
        EasyLoading.showToast(resultMap['msg']);
        DiaLogUtil.disMiss(context);
        setState(() {
          agencyList.clear();
          noData = true;
          finishRefresh(isrefresh);
        });
      }
    } catch (e) {
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
      setState(() {
        agencyList.clear();
        noData = true;
        finishRefresh(isrefresh);
      });
    }
  }

  @override
  listbuilder() {
    // TODO: implement listbuilder
    return ListView.builder(
        itemCount: agencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {},
                  onLongPress: () {
                    EasyLoading.showToast(agencyList[index]["description"]);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //行号
                        CommonTextForm(
                            title: Constants.LINE_NO,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["udinvuselinenum"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //编码
                        CommonTextForm(
                            title: Constants.GSJ_ITEM_NO,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["uditemnum"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //描述
                        CommonTextForm(
                            title: Constants.DESC,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["description"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //批次
                        CommonTextForm(
                            title: Constants.LOT_NUM,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["fromlot"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //库房
                        CommonTextForm(
                            title: Constants.STORE_ROOM,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["locdes"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //货位
                        CommonTextForm(
                            title: Constants.PRODUCT_LOCTION,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["binname"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //待归还数量
                        // CommonTextForm(
                        //     title: Constants.WAIT_BACK_COUNT,
                        //     titlecolor: Colors.black,
                        //     titleSize: TextSizeConfig.size16,
                        //     content: agencyList[index]["quantity"],
                        //     contentcolor: Colors.black,
                        //     contentSize: TextSizeConfig.size16),

                        //归还数量
                        CommonTextInputForm(
                          from: "back",
                          title: Constants.BACK_COUNT,
                          titlecolor: Colors.black,
                          titleSize: TextSizeConfig.size16,
                          imageSize: 25,
                          content: agencyList[index]["quantity"].toString().isNotEmpty ?agencyList[index]["quantity"]:"0.0" ,
                          keyBoardtype: TextInputType.number,
                          maxvalue: agencyList[index]["quantity"].toString().isNotEmpty ?agencyList[index]["quantity"]:"0.0",
                          hint: '请输入归还数量',
                          statue1: statue,
                          statue2: agencyList[index]['status'],
                          callback: (s) {
                            //主表待归还/部分归还/驳回
                            if (statue == Constants.WAIT_TO_BACK ||
                                statue == Constants.PART_OF_BACK ||
                                statue == Constants.REJECTED) {
                              //子表等待检查
                              if (agencyList[index]['status'] ==
                                  Constants.WAIT_CHECK) {
                                if (s.isEmpty) {
                                  EasyLoading.showInfo('请输入归还数量');
                                  return;
                                } else   if(num.parse(s)<=0){
                                  EasyLoading.showInfo(Constants.COUNT_SHOULD_MORE_THEN_ZERO);
                                }else
                                  modfy(s, agencyList[index]['udyjid'],1);
                              } else {
                                EasyLoading.showInfo(
                                    Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                              }
                            } else {
                              EasyLoading.showInfo(
                                  Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                            }
                          },
                          flag: 1,
                        ),

                        //发放单位
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextForm(
                                  title: Constants.FF_DEPT,
                                  titlecolor: Colors.black,
                                  titleSize: TextSizeConfig.size16,
                                  content: agencyList[index]["uddw"],
                                  contentcolor: Colors.black,
                                  contentSize: TextSizeConfig.size16),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text('是否检查：',style: TextStyle(fontSize: TextSizeConfig.size16),),
                                  Switch(
                                    trackColor:
                                        MaterialStateProperty.all(Colors.black38),
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.grey.withOpacity(0.8),
// when the switch is on, this image will be displayed
//                               activeThumbImage:
//                                   const AssetImage('assets/happy_emoji.png'),
// // when the switch is off, this image will be displayed
//                               inactiveThumbImage:
//                                   const AssetImage('assets/sad_emoji.png'),
                                    value: agencyList[index]['udsfjc']=="Y" ? true:false,
                                    onChanged: (value) {
                                        LogD('value=${value}');
                                        //主表待归还/部分归还/驳回
                                        if (statue == Constants.WAIT_TO_BACK ||
                                            statue == Constants.PART_OF_BACK ||
                                            statue == Constants.REJECTED) {
                                          //子表等待检查
                                          if (agencyList[index]['status'] ==
                                              Constants.WAIT_CHECK) {
                                            setState(() {
                                              modfy(value==true?"Y":"N", agencyList[index]['udyjid'],2);

                                            });
                                          }else {
                                            EasyLoading.showInfo(
                                                Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                                          }}
                                        else {
                                          EasyLoading.showInfo(
                                            Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                                        }


                                  },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //单位成本
                        CommonTextForm(
                            title: Constants.UNIT_COST,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["unitcost"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //行成本
                        CommonTextForm(
                            title: Constants.LINE_COST,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["linecost"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //创建日期
                        // CommonImageTextItem(
                        //     icon: Icons.access_time,
                        //     text: agencyList[index]["requesteddate"],
                        //     textcolor: Colors.black45,
                        //     imagecolor: Colors.orange,
                        //     onPressed: () {},
                        //     textSize: TextSizeConfig.size16,
                        //     imageSize: 18),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: CommonTopRightTag(
                        tag: agencyList[index]["status"],
                        size: TextSizeConfig.size70,
                      ))),
              Positioned(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        onPressed: () {
                          //主表 待归还/部份归还/驳回
                          if (statue == Constants.WAIT_TO_BACK ||
                              statue == Constants.PART_OF_BACK ||
                              statue == Constants.REJECTED) {
                            //子表 等待检查
                            if (agencyList[index]['status'] ==
                                Constants.WAIT_CHECK) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CommonDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop("yes");
                                        removeItem(agencyList[index]['udyjid']);
                                      },
                                      warm: Constants.SURE_DELETE,
                                    );
                                  });
                            } else {
                              EasyLoading.showInfo(
                                  Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                            }
                          } else
                            EasyLoading.showInfo(
                                Constants.CURRENT_STATUE_COUND_NOT_OPERATE);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  @override
  add() {
    // TODO: implement add
    //待归还 驳回
    if (statue == Constants.WAIT_TO_BACK ||
        statue == Constants.PART_OF_BACK ||
        statue == Constants.REJECTED) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GsjCommonAddPage(
                num: no,
                location: location,
                from: "back",
              )));
      return;
    } else
      EasyLoading.showInfo('非 待归还/驳回 状态下无法新增');
  }

  Future<void> removeItem(id) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.DELETE;
    Map map = {
      "objectName": "UDINVUSELINE",
      "keyName": "UDINVUSELINEID",
      "keyValue": id,
    };
    list.add(map);

    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost2('${name}', option, list);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        getGsjList(true);
        KeyBordUtil.hidekeybord(context);
        // eventBus.fire(EventA(  Constants.REFRESH_GSJ));
      } else {
        EasyLoading.showToast(resultMap['msg']);
        // DiaLogUtil.disMiss(context);
      }
    } catch (e) {
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
    }
  }

  Future<void> modfy(String s, String id,int flag) async {
    list.clear();
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.MODIFY;
    Map map = {
      "objectName": "UDINVUSELINE",
      "keyName": "UDINVUSELINEID",
      "keyValue": id,
      if(flag==1)
      "QUANTITY": s,
      if(flag==2)
        "UDSFJC": s,

    };
    list.add(map);
    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost2('${name}', option, list);
      if (resultMap['code'] == Constants.CODE_OK) {
        getGsjList(true);
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        // eventBus.fire(EventA(  Constants.REFRESH_GSJ));
      } else {
        EasyLoading.showToast(resultMap['msg']);
        DiaLogUtil.disMiss(context);
      }
    } catch (e) {
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
    }
  }
}
