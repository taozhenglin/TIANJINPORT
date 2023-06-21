import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twst/bean/eventbus.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/service/dioclent.dart';
import 'package:twst/tools/datautil.dart';
import 'package:twst/tools/hightutils.dart';
import 'package:twst/view/common_icontext_item.dart';
import 'package:twst/view/common_search_bar.dart';

import '../config/textsize.dart';
import '../main.dart';
import '../tools/dialogutil.dart';
import '../view/animationwg.dart';

class MsgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MsgPageState();
  }
}

class _MsgPageState extends State<MsgPage> {
  List agencyList = [];

  int start = 10;
  bool noData = false;
  late int end;
  late String searchInput = "";
  int _startPage = Constants.START_PAGE;
  int _endPage = Constants.END_PAGE;
  late int total;

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 300), () {
      getTaskList(true, "");
    });
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            '待办事项',
            style:
                TextStyle(fontSize: TextSizeConfig.size20, color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            CommonSeachBar(
              hint: '请输入单号或描述',
              hintSize: 14,
              hintColor: Colors.black54,
              icon: Icons.search,
              onSearch: (e) {
                searchInput = e.toString();
                hidekeybord();
                getTaskList(true, searchInput);
                print("搜索输出=====$e");
              },
            ),
            Expanded(
              child: noData
                  ? GestureDetector(
                      onTap: onRefresh,
                      child:
                          Image.asset("images/nodata.png", fit: BoxFit.cover),
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      controller: refreshController,
                      onRefresh: onRefresh,
                      onLoading: onLoading,
                      child: listbuilder()),
            )
          ],
        ));
  }

  void onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
    _startPage = Constants.START_PAGE;
    _endPage = Constants.END_PAGE;

    getTaskList(true, searchInput);
  }

  void onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.addAll((items));
    print("_onLoading======");
    _startPage = _endPage + 1;
    _endPage = _endPage + Constants.END_PAGE;
    getTaskList(false, searchInput);
    // if (mounted) setState(() {});
    // _refreshController.loadComplete();
  }

  /**
   *  下拉刷新 true 上拉加载false
   */
  getTaskList(bool refresh, String input) async {
    String string = await DataUtils.getString("username");
    if (refresh) {
      _startPage = Constants.START_PAGE;
      _endPage = Constants.END_PAGE;
    }
    DiaLogUtil.show(context, Colors.black12, '加载中...');
    print("_startPage======$_startPage");
    print("_endPage======$_endPage");
    var sqlWhere = "ACTIVE";
    Map mapJaon = {
      "keyNum": Constants.TASK_LIST,
      "sqlWhere":
          " and assignstatus='$sqlWhere'  and assigncode='${string?.toUpperCase()}'",
      "sinorSearch": input,
      "startRow": _startPage.toString(),
      "endRow": _endPage.toString()
    };

    try {
      Map<String, dynamic> resultMap = await DioClient.DioPost(
          await DataUtils.getString("loginname"), Constants.READ, mapJaon);
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
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: agencyList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: buildContainer(agencyList[index], searchInput),
                ),
              ),
            );
          },
        ),
      ),
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
                    text: bean["appname"],
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
                  text: bean["duedate"],
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
                  text: bean["appname"],
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
                text: bean["duedate"],
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
