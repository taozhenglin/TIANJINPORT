import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/base/baselistfragment.dart';

import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/logutils.dart';
import '../view/common_imagetext_item.dart';
import '../view/commontextform.dart';

class GsjCjRecordPage extends BaseListFragment {
  final String num;
  GsjCjRecordPage({Key? key, required this.num});
  @override
  BaseListFragmentState createState() {
    // TODO: implement createState
    return GsjCjRecordPageState(num);
  }
}

class GsjCjRecordPageState extends BaseListFragmentState {
  List agencyList = [];
  late String name;
  late String num;
  GsjCjRecordPageState(this.num);
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
    LogD('num=${num}');
    Future.delayed(Duration(microseconds: 300), () {
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
      "keyNum": Constants.GSJ_CJ_RECORD_LIST,
      "sqlWhere": " and UDINVUSENUM='${num}' ",
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
            children: [
              Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/gsj_cj_line', arguments: {
                      "num": num,
                      "cjnum": agencyList[index]['udjycjnum']
                    });
                  },
                  onLongPress: () {
                    EasyLoading.showToast(agencyList[index]["description"]);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //承接号
                        CommonTextForm(
                            title: Constants.CJ_NUM,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["udjycjnum"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //承接人
                        CommonTextForm(
                            title: Constants.CJ_PERSON,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["udcjperson"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //承接部门
                        CommonTextForm(
                            title: Constants.CJ_DEPT,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["deptno"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //公司
                        CommonTextForm(
                            title: Constants.COMPANY,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["siteid"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //承接日期
                        CommonImageTextItem(
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
