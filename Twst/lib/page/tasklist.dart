
import 'package:flutter/material.dart';
import 'package:twst/base/baselist_page.dart';

import '../bean/eventbus.dart';
import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/hightutils.dart';
import '../view/common_icontext_item.dart';
import 'msg.dart';

class TaskListPage extends BaseListPage{
  @override
  BaseListPageState createState() {
    // TODO: implement createState
    return TaskListState();
  }
}

class TaskListState extends BaseListPageState{
  List agencyList = [];
  late String name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 300),(){
      getTaskList(true, "");
    });  }

  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
   String  username = await DataUtils.getString("loginname");
   setState(() {
     name=username;
     hint=Constants.PLEASE_FILL_IN_NUM_OR_DESC;
   });

  }
  @override
  void search() {
    // TODO: implement search
    super.search();
    getTaskList(true, searchInput);
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
    getTaskList(true, searchInput);
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
    super.onLoading();
    getTaskList(false, searchInput);
  }
  /**
   *  下拉刷新 true 上拉加载false
   */
  getTaskList(bool refresh, String input) async {

    if (refresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    DiaLogUtil.show(context, Colors.black12, '加载中...');
    var sqlWhere = "活动";
    Map mapJaon = {
      "keyNum": Constants.TASK_LIST,
      "sqlWhere":
      " and assignstatus='${sqlWhere}'  and processname='UDGSJJYGH' and assigncode='${name}' ",
      "sinorSearch":"",
      "startRow":startPage,
      "endRow":endPage,
      "sinorSearch": input,
    };

    try {
      Map<String, dynamic> resultMap = await DioClient.DioPost(
          '${name}', Constants.READ, mapJaon);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);

        List _agencyList = resultMap['msg'];
        total = int.parse(resultMap['total']);
        eventBus.fire(EventB(resultMap['total']));
        DataUtils.setString('taskcount', resultMap['total']);
        if (mounted) {
          setState(() {
            if (total > 0) {
              //有数据
              finishRefresh(refresh);
              if (_agencyList.isNotEmpty) {
                noData = false;
                //下拉刷新
                if (refresh) {
                  agencyList = _agencyList;
                } else {
                  //上拉加载
                  agencyList.addAll(_agencyList);
                }
              } else {
                // ToastUtils.shotToast(Constants.NO_MORE_DATA);
                print("_agencyList.isEmpty");
                refreshController.loadNoData();
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
          finishRefresh(refresh);
        });
      }
    } catch (e) {
      print(e.toString());
      DiaLogUtil.disMiss(context);
      setState(() {
        agencyList.clear();
        noData = true;
        finishRefresh(refresh);
      });
    }

    var length = agencyList.length;
    print("agencyList======$length");

    // setState(() {});
  }
  listbuilder() {
    // return ListView.builder(
    //   // physics: const ClampingScrollPhysics(),
    //   cacheExtent: 0,
    //   itemBuilder: (c, i) =>
    //       MsgItem(index: i, bean: agencyList[i], input: searchInput),
    //   itemCount: agencyList.length,
    // );
    return
      ListView.builder(
        itemCount: agencyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: InkWell(
              onTap: () {

                Navigator.of(context).pushNamed('/gsj_borrow_back_detail',
                    arguments: {"data": agencyList[index],"from":"task"});
                // Navigator.pushNamed(
                //     navigatorKey.currentState.overlay.context, '/test');
              },
              child: Card(
                elevation: 3,
                margin: EdgeInsets.all(3),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: LightText(
                          text: agencyList[index]["app"],
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
                      LightText(
                          text: agencyList[index]["description"],
                          lightText: searchInput,
                          textStyle: TextStyle(
                            fontSize: TextSizeConfig.size16,
                            color: Colors.black45,
                          ),
                          lightStyle: TextStyle(
                              fontSize: TextSizeConfig.size18,
                              color: Colors.tealAccent)),
                      CommonIconTextItem(
                        icon: Icons.access_time,
                        text: agencyList[index]["startdate"],
                        imagecolor: Colors.orange,
                        onPressed: () {},
                        textSize: TextSizeConfig.size16,
                        imageSize: 18,
                        textcolor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          // child: MsgItem(index: index, bean: agencyList[index], input: searchInput),



        },
      );


  }

}
Container buildContainer(bean, String input) {
  return Container(
    padding: EdgeInsets.all(5),
    child: InkWell(
      onTap: () {
        // Navigator.pushNamed(
        //     navigatorKey.currentState.overlay.context, '/test');
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(3),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: LightText(
                  text: bean["app"],
                  lightText: input,
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
              LightText(
                  text: bean["description"],
                  lightText: input,
                  textStyle: TextStyle(
                    fontSize: TextSizeConfig.size16,
                    color: Colors.black45,
                  ),
                  lightStyle: TextStyle(
                      fontSize: TextSizeConfig.size18,
                      color: Colors.tealAccent)),
              CommonIconTextItem(
                icon: Icons.access_time,
                text: bean["startdate"],
                imagecolor: Colors.orange,
                onPressed: () {},
                textSize: TextSizeConfig.size16,
                imageSize: 18,
                textcolor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

