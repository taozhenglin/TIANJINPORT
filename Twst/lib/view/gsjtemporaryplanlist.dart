import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/tools/logutils.dart';

import '../base/baselistpage.dart';
import '../bean/eventbus.dart';
import '../config/textsize.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/hightutils.dart';
import 'common_imagetext_item.dart';

class GsjTemporaryPlanList extends BaseListPage {
  @override
  BaseListPageState createState() {
    // TODO: implement createState
    return GsjTemporaryPlanListPage();
  }
}

class GsjTemporaryPlanListPage extends BaseListPageState {
  List agencyList = [];
  late String name;
  late String siteid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(microseconds: 300), () {
      getGsjList(true, searchInput);
    });
  }

  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
    title = Constants.GSJ_BORROW_BACK;
    hint = Constants.GSJ_LIST_HINT;
    name = await DataUtils.getString("loginname");
    siteid = await DataUtils.getString("siteid");
  }

  @override
  void search() {
    // TODO: implement search
    super.search();
    getGsjList(true, searchInput);
  }

  @override
  close() {
    // TODO: implement close
    Navigator.of(context).pop();
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
    super.onRefresh();
    getGsjList(true, searchInput);
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
    super.onLoading();
    getGsjList(false, searchInput);
  }

  @override
  listbuilder() {
    // TODO: implement listbuilder
    return ListView.builder(
        itemCount: agencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/gsj_temporary_plan',
                    arguments: {"data": agencyList[index]});
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //单号
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.NO,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: LightText(
                            text: agencyList[index]["num"],
                            lightText: searchInput,
                            textStyle: TextStyle(
                                fontSize: TextSizeConfig.size16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            lightStyle: TextStyle(
                              fontSize: TextSizeConfig.size18,
                              color: Colors.tealAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //描述
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.DESC,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        LightText(
                            text: agencyList[index]["desc"],
                            lightText: searchInput,
                            textStyle: TextStyle(
                              fontSize: TextSizeConfig.size16,
                              color: Colors.black45,
                            ),
                            lightStyle: TextStyle(
                                fontSize: TextSizeConfig.size18,
                                color: Colors.tealAccent)),
                      ],
                    ),
                    //创建人
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.CREATED_BY,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          agencyList[index]["requestedby"],
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        )
                      ],
                    ),
                    //创建人部门
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.CREATED_DEPT,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          agencyList[index]["dept"],
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        )
                      ],
                    ),
                    //仓库
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.STOREHOUSE,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          agencyList[index]["locdes"],
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    //地点
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.LOCATION,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          agencyList[index]["sitedec"],
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        )
                      ],
                    ),
                    //状态日期
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Constants.STATUE_DATE,
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          agencyList[index]["statusdate"],
                          style: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                        )
                      ],
                    ),
                    //创建日期
                    CommonImageTextItem(
                        icon: Icons.access_time,
                        text: agencyList[index]["requesteddate"],
                        textcolor: Colors.black45,
                        imagecolor: Colors.orange,
                        onPressed: () {},
                        textSize: TextSizeConfig.size16,
                        imageSize: 18),
                  ],
                ),
              ),
            ),
          );
        });

    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: agencyList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       padding: EdgeInsets.only(left: 3, right: 3, bottom: 2),
    //       child: InkWell(
    //         onTap: () {
    //           // Navigator.pushNamed(
    //           //     navigatorKey.currentState.overlay.context, '/test');
    //         },
    //         child: Card(
    //           elevation: 3,
    //           child: Padding(
    //             padding: EdgeInsets.all(10),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       Constants.NO,
    //                       style: TextStyle(
    //                         fontSize: TextSizeConfig.size16,
    //                         color: Colors.black45,
    //                       ),
    //                     ),
    //                     Container(
    //                       alignment: Alignment.topLeft,
    //                       child: LightText(
    //                         text: agencyList[index]["num"],
    //                         lightText: searchInput,
    //                         textStyle: TextStyle(
    //                             fontSize: TextSizeConfig.size16,
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.bold),
    //                         lightStyle: TextStyle(
    //                           fontSize: TextSizeConfig.size18,
    //                           color: Colors.tealAccent,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       Constants.DESC,
    //                       style: TextStyle(
    //                         fontSize: TextSizeConfig.size16,
    //                         color: Colors.black45,
    //                       ),
    //                     ),
    //                     LightText(
    //                         text: agencyList[index]["desc"],
    //                         lightText: searchInput,
    //                         textStyle: TextStyle(
    //                           fontSize: TextSizeConfig.size16,
    //                           color: Colors.black45,
    //                         ),
    //                         lightStyle: TextStyle(
    //                             fontSize: TextSizeConfig.size18,
    //                             color: Colors.tealAccent)),
    //                   ],
    //                 ),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       Constants.COMPANY_DESC,
    //                       style: TextStyle(
    //                         fontSize: TextSizeConfig.size16,
    //                         color: Colors.black45,
    //                       ),
    //                     ),
    //                     LightText(
    //                         text: agencyList[index]["sitedec"],
    //                         lightText: searchInput,
    //                         textStyle: TextStyle(
    //                           fontSize: TextSizeConfig.size16,
    //                           color: Colors.black45,
    //                         ),
    //                         lightStyle: TextStyle(
    //                             fontSize: TextSizeConfig.size18,
    //                             color: Colors.tealAccent)),
    //                   ],
    //                 ),
    //                 CommonImageTextItem(
    //                     icon: Icons.access_time,
    //                     text: agencyList[index]["requesteddate"],
    //                     textcolor: Colors.black12,
    //                     imagecolor: Colors.orange,
    //                     onPressed: () {},
    //                     textSize: TextSizeConfig.size16,
    //                     imageSize: 18),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  // Container buildContainer(int index, String input) {
  // }

  Future<void> getGsjList(bool isrefresh, String search) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh}  ${hint}');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map json = {
      "keyNum": Constants.GSJ_LIST,
      "sqlWhere": " and siteid='${siteid}' ",
      "sinorSearch": search,
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
        DiaLogUtil.disMiss(context);
        eventBus.fire(EventB("0"));
        DataUtils.setString('taskcount', '0');
        // ToastUtils.shotToast(resultMap['msg']);
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
  closed() {
    // TODO: implement closed
    Navigator.of(context).pop();
  }
}
