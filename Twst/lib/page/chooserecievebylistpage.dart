
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/base/baselist_page.dart';
import 'package:twst/view/common_light_text_item.dart';

import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/logutils.dart';
import '../view/commontextform.dart';

class ChooseRecieveByListPage extends BaseListPage{
  late String tag;
  ChooseRecieveByListPage({Key? key, required this.tag});

  @override
  BaseListPageState createState() {
    // TODO: implement createState
    return ChooseRecieveByListPageState(tag);
  }
}

class ChooseRecieveByListPageState extends BaseListPageState{
  List agencyList = [];
  // late  num;
  late String name;
  late String siteid;
  late String tag='';
  late String keynum;
  late String sql;
  ChooseRecieveByListPageState(this.tag);
  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
    name = await DataUtils.getString("loginname");
    siteid = await DataUtils.getString("siteid");
    if(tag=="recieve"){
      title = "选择领用人";
      hint="请输入姓名/id";
      keynum=Constants.GSJ_CHOOSE_RECIEVE_LIST;
      sql=" and locationsite='${siteid}'";
    }else{
      title = "选择仓库";
      hint="请输入仓库/id";
      keynum=Constants.GSJ_CHOOSE_STORE_LIST;
      sql="and siteid='${siteid}' and  type='库房' ";
    }

    showSearchBar = true;
  }
  @override
  void onRefresh() {
    // TODO: implement onRefresh
    super.onRefresh();
    getReciveByList(true);
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
    super.onLoading();
    getReciveByList(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 300), () {
      getReciveByList(true);
    });
  }

  Future<void> getReciveByList(bool isrefresh) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh} ');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map json = {
      "keyNum": keynum,
      "sqlWhere":
      sql,
      "sinorSearch": '',
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
    if(tag=="recieve"){
      return ListView.builder(
        itemCount: agencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, agencyList[index]);
                    // Navigator.of(context).pushNamed('/gsj_temporary_plan',
                    //     arguments: {"data": agencyList[index]});
                  },
                  onLongPress: () {
                    // EasyLoading.showToast(agencyList[index]["description"]);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //姓名
                        CommonLightTextItem(title: Constants.GSJ_DESC, titlecolor: Colors.black, titleSize: TextSizeConfig.size16, content: agencyList[index]["DISPLAYNAME"], contentcolor:  Colors.black, contentSize: TextSizeConfig.size16, searchInput: searchInput),
                        // CommonTextForm(
                        //     title: Constants.GSJ_DESC,
                        //     titlecolor: Colors.black,
                        //     titleSize: TextSizeConfig.size16,
                        //     content: agencyList[index]["DISPLAYNAME"],
                        //     contentcolor: Colors.black,
                        //     contentSize: TextSizeConfig.size16),
                        //部门
                        CommonTextForm(
                            title: Constants.DEPT,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["UDBM"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //职称
                        CommonTextForm(
                            title: Constants.LEVEL,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["EMPLOYEETYPE"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //人员id
                        CommonLightTextItem(title: Constants.PERSON_ID, titlecolor: Colors.black, titleSize: TextSizeConfig.size16, content: agencyList[index]["PERSONID"], contentcolor:  Colors.black, contentSize: TextSizeConfig.size16, searchInput: searchInput),



                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //     child: Align(
              //         alignment: Alignment.topRight,
              //         child: CommonTopRightTag(
              //           tag: agencyList[index]["status"],
              //           size: TextSizeConfig.size70,
              //         ))),
            ],
          );
        });}else{
      return ListView.builder(
          itemCount: agencyList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, agencyList[index]);
                      // Navigator.of(context).pushNamed('/gsj_temporary_plan',
                      //     arguments: {"data": agencyList[index]});
                    },
                    onLongPress: () {
                      // EasyLoading.showToast(agencyList[index]["description"]);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //姓名
                          CommonLightTextItem(title: Constants.STORE_ROOM, titlecolor: Colors.black, titleSize: TextSizeConfig.size16, content: agencyList[index]["LOCATION"], contentcolor:  Colors.black, contentSize: TextSizeConfig.size16, searchInput: searchInput),
                          // CommonTextForm(
                          //     title: Constants.GSJ_DESC,
                          //     titlecolor: Colors.black,
                          //     titleSize: TextSizeConfig.size16,
                          //     content: agencyList[index]["DISPLAYNAME"],
                          //     contentcolor: Colors.black,
                          //     contentSize: TextSizeConfig.size16),
                          //部门
                          // CommonTextForm(
                          //     title: Constants.DEPT,
                          //     titlecolor: Colors.black,
                          //     titleSize: TextSizeConfig.size16,
                          //     content: agencyList[index]["UDBM"],
                          //     contentcolor: Colors.black,
                          //     contentSize: TextSizeConfig.size16),

                          //职称
                          // CommonTextForm(
                          //     title: Constants.LEVEL,
                          //     titlecolor: Colors.black,
                          //     titleSize: TextSizeConfig.size16,
                          //     content: agencyList[index]["EMPLOYEETYPE"],
                          //     contentcolor: Colors.black,
                          //     contentSize: TextSizeConfig.size16),

                          //人员id
                          CommonLightTextItem(title: Constants.DESC, titlecolor: Colors.black, titleSize: TextSizeConfig.size16, content: agencyList[index]["DESCRIPTION"], contentcolor:  Colors.black, contentSize: TextSizeConfig.size16, searchInput: searchInput),



                        ],
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //     child: Align(
                //         alignment: Alignment.topRight,
                //         child: CommonTopRightTag(
                //           tag: agencyList[index]["status"],
                //           size: TextSizeConfig.size70,
                //         ))),
              ],
            );
          });

    }

  }
@override
  void search() {
    // TODO: implement search
  getReciveByList(true);
  }
}