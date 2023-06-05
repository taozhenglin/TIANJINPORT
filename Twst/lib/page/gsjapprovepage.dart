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

class GsjApprovePage extends BaseListFragment{
  final num;
  final ownerId;
  GsjApprovePage({Key? key, required this.num, required this.ownerId});

  @override
  BaseListFragmentState createState() {
    // TODO: implement createState
    return GsjApprovePageState(num,ownerId);
  }
  
}
class GsjApprovePageState extends BaseListFragmentState {
  List agencyList = [];
  late String name;
  late String num;
  late String  ownerId;

  GsjApprovePageState(this.num,this.ownerId);
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
      "keyNum": Constants.GSJ_APPROVE__RECORD_LIST,
      "sqlWhere": " and ownertable = 'UDINVUSE' and ownerid = ${ownerId}  and transtype in ('开始的 WF','分配完成的 WF')",
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

                  },
                  onLongPress: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //审核节点
                        CommonTextForm(
                            title: Constants.APPROVE_DOT,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["assign"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),
                        //审批人
                        CommonTextForm(
                            title: Constants.APPROVE_BY,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["udsp"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //流转至审核人日期
                        CommonTextForm(
                            title: Constants.TO_APPROVE_DATE,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["startdate"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                        //审核日期
                        CommonTextForm(
                            title: Constants.APPROVE_TIME,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["transdate"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),



                        //审批意见
                        CommonTextForm(
                            title: Constants.APPROVE_MEMO,
                            titlecolor: Colors.black,
                            titleSize: TextSizeConfig.size16,
                            content: agencyList[index]["memo"],
                            contentcolor: Colors.black,
                            contentSize: TextSizeConfig.size16),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          );
        });
  }




}
