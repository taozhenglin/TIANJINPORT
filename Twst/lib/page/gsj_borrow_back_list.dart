import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/tools/golbal_refresh.dart';
import 'package:twst/tools/logutils.dart';
import 'package:twst/view/common_light_text_item.dart';
import '../base/baselist_page_with_flb.dart';
import '../bean/eventbus.dart';
import '../config/textsize.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/hightutils.dart';
import '../view/common_icontext_item.dart';
import '../view/commontoprighttag.dart';
import 'add_gsjdetail_page.dart';
import 'gsj_detail_page.dart';

class GsjBorrowBackList extends BaseListPageWithFlb {
  @override
  BaseListPageWithFlbState createState() {
    // TODO: implement createState
    return GsjBorrowBackListState();
  }
}

class GsjBorrowBackListState extends BaseListPageWithFlbState {
  List agencyList = [];
  late String name;
  late String siteid;
  var listen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listen = eventBus.on<EventA>().listen((event) {
      print("接受到刷新${event.str}");
      if (event.str.isNotEmpty) {
        if(event.str==Constants.REFRESH_GSJ){
          getGsjList(true, searchInput);
        }
      }
    });
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
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              //滑动
              child: SlideAnimation(
            verticalOffset: 50,
            //渐显
            child: FadeInAnimation(
              child:  Stack(
                children: [
                  Card(
                    elevation: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/gsj_borrow_back_detail',
                            arguments: {"data": agencyList[index],"from":"list"});
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
                                  ),
                                ),
                                Expanded(
                                  child: LightText(
                                      text: agencyList[index]["desc"],
                                      lightText: searchInput,
                                      textStyle: TextStyle(
                                        fontSize: TextSizeConfig.size16,
                                        color: Colors.black,
                                      ),
                                      lightStyle: TextStyle(
                                          fontSize: TextSizeConfig.size18,
                                          color: Colors.tealAccent)),
                                ),
                              ],
                            ),
                            //创建人
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       Constants.CREATED_BY,
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       agencyList[index]["requestedby"],
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black,
                            //       ),
                            //     )
                            //   ],
                            // ),
                            CommonLightTextItem(title: Constants.CREATED_BY, titlecolor: Colors.black87, titleSize: TextSizeConfig.size16, content: agencyList[index]["requestedby"], contentcolor: Colors.cyanAccent, contentSize: TextSizeConfig.size18, searchInput: searchInput,),
                            //创建人部门
                            CommonLightTextItem(title: Constants.CREATED_DEPT, titlecolor: Colors.black87, titleSize: TextSizeConfig.size16, content: agencyList[index]["dept"], contentcolor: Colors.cyanAccent, contentSize: TextSizeConfig.size18, searchInput: searchInput,),

                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       Constants.CREATED_DEPT,
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       agencyList[index]["dept"],
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black,
                            //       ),
                            //     )
                            //   ],
                            // ),
                            //仓库
                            CommonLightTextItem(title: Constants.STOREHOUSE, titlecolor: Colors.black87, titleSize: TextSizeConfig.size16, content: agencyList[index]["locdes"], contentcolor: Colors.cyanAccent, contentSize: TextSizeConfig.size18, searchInput: searchInput,),

                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       Constants.STOREHOUSE,
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       agencyList[index]["locdes"],
                            //       style: TextStyle(
                            //         fontSize: TextSizeConfig.size16,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            //地点
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Constants.LOCATION,
                                  style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  agencyList[index]["sitedec"],
                                  style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.black,
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
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  agencyList[index]["statusdate"],
                                  style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            //创建日期
                            CommonIconTextItem(
                                icon: Icons.access_time,
                                text: agencyList[index]["requesteddate"],
                                textcolor: Colors.black,
                                imagecolor: Colors.orange,
                                onPressed: () {},
                                textSize: TextSizeConfig.size16,
                                position: MainAxisAlignment.start,
                                imageSize: 18),
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
                ],
              ),

            ),

          ));
        });
  }

  Future<void> getGsjList(bool isrefresh, String search) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh}  ${hint}');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map map = {
      "keyNum": Constants.GSJ_LIST,
      "sqlWhere": " and siteid='${siteid}' ",
      "sinorSearch": search,
      "startRow": startPage,
      "endRow": endPage
    };
    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost('${name}', option, map);
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
        EasyLoading.showToast(resultMap['msg']);
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
  @override
  add() {
    // TODO: implement add
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddGsjDetailPage()));
  }
}




