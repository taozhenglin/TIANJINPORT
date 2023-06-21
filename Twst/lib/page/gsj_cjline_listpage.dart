import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/base/baselist_fragment.dart';
import 'package:twst/base/baselist_page.dart';

import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/logutils.dart';
import '../view/common_icontext_item.dart';
import '../view/commontextform.dart';

class GsjCjLineListPage extends BaseListPage {
  final arguments;
  GsjCjLineListPage({Key? key, required this.arguments});
  @override
  BaseListPageState createState() {
    // TODO: implement createState
    return GsjCjLineListPageState(arguments);
  }
}

class GsjCjLineListPageState extends BaseListPageState {
  List agencyList = [];
  // late String num;
  // late String cjnum;
  late String name;
  final arguments;
  GsjCjLineListPageState(this.arguments);

  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
    name = await DataUtils.getString("loginname");
    title = "承接明细";
    showSearchBar = false;
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
    super.onRefresh();
    getCjLineList(true);
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
    super.onLoading();
    getCjLineList(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogD('num==${arguments['num']}');
    LogD('cjnum==${arguments['cjnum']}');
    Future.delayed(Duration(microseconds: 300), () {
      getCjLineList(true);
    });
  }

  Future<void> getCjLineList(bool isrefresh) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh} ');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map json = {
      "keyNum": Constants.GSJ_CJ_LINE_LIST,
      "sqlWhere":
          " and UDINVUSENUM='${arguments['num']}' and UDJYCJNUM='${arguments['cjnum']}'",
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
    return ListView.builder(
        itemCount: agencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
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
                        //行号
                        CommonTextForm(
                            title: Constants.CJ_NUM,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["udjycjnum"],
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

                        //承接数量
                        CommonTextForm(
                            title: Constants.CJ_COUNT,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["cjquantity"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

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
                        //承接日期
                        CommonIconTextItem(
                            icon: Icons.access_time,
                            text: agencyList[index]["udcjdate"],
                            textcolor: Colors.black45,
                            imagecolor: Colors.orange,
                            onPressed: () {},
                            textSize: TextSizeConfig.size16,
                            imageSize: 18),
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
