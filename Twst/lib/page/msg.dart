import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twst/base/baselist_page.dart';
import 'package:twst/bean/eventbus.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/service/dioclent.dart';
import 'package:twst/tools/datautil.dart';
import 'package:twst/tools/hightutils.dart';
import 'package:twst/tools/logutils.dart';
import 'package:twst/view/common_icontext_item.dart';
import 'package:twst/view/common_search_bar.dart';

import '../config/textsize.dart';
import '../main.dart';
import '../tools/dialogutil.dart';
import '../view/animationwg.dart';

class MsgPage extends BaseListPage {
  @override
  BaseListPageState  createState() {
    // TODO: implement createState
    return _MsgPageState();
  }
}

class _MsgPageState extends BaseListPageState {
  List agencyList = [];
  late String name;


  @override
  void initState() {
    Future.delayed(Duration(microseconds: 300),(){
      getTaskList(true, "");
    });
  }
  @override
  Future<void> initData() async {
    // TODO: implement initData
    super.initData();
    name = await DataUtils.getString("loginname");
    LogD('name=$name');

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
                  return buildContainer(agencyList[index], searchInput);
                  // child: MsgItem(index: index, bean: agencyList[index], input: searchInput),



          },
        );


  }

  void finishRefresh(bool refresh) {
    if (refresh) {
      refreshController.refreshCompleted();
    } else {
      refreshController.loadComplete();
    }
  }

  void hidekeybord() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }


}

class MsgItem extends StatelessWidget {
  final int index;
  var bean;
  String input;
  MsgItem(
      {Key? key, required this.index, required this.bean, required this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double top = index == 0 ? 10 : 0;
    return Container(
      // padding: EdgeInsets.only(top: top, bottom: 0),
      child: buildAnimationWidget(bean, input),
    );
  }

  AnimationWdiget buildAnimationWidget(bean, String input) {
    return AnimationWdiget(
      flag: 1,
      duration: 400 + index % 3 * 100,
      child: buildContainer(bean, input),
    );
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
                    text: bean["ownerTable"],
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
  // fun( bean) {
  //   print('bean==$bean');
  //
  // }
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
