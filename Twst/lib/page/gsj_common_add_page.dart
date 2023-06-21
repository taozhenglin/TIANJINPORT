import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twst/base/baselist_page.dart';
import 'package:twst/view/common_light_text_item.dart';

import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/keybord.dart';
import '../tools/logutils.dart';
import '../view/common_search_bar.dart';
import '../view/commontextform.dart';

class GsjCommonAddPage extends StatefulWidget {
  final location;
  final num;
  final from;
  GsjCommonAddPage({Key? key, required this.location,required this.num, this.from});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GsjCommonAddPageState(location,num,from);
  }
}

class GsjCommonAddPageState extends State<GsjCommonAddPage> {
  List<String> addList = []; //要删除的ID数组
  List<Map> _list = []; //列表

  late Widget appBarWidget; //body
  late String title = '';
  late String hint = '';
  late double hintSize = TextSizeConfig.size14;
  late Color hintColor = Colors.grey;
  late IconData icon;
  bool noData = false;
  late int startPage = Constants.START_PAGE;
  late int endPage = Constants.END_PAGE;
  late int total;
  late String searchInput = "";
  late bool isNetWorkAvailable = true;
  late bool showSearchBar = true;
  late bool showFlb = true;
  bool _isOff = true; //相关组件显示隐藏控制，true代表隐藏
  bool _checkValue = false; //总的复选框控制开关
  List agencyList = [];
  late String name;
  late String location;
  late String num;
  late String from;

  GsjCommonAddPageState(this.location, this.num, this.from);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogD('location==${location}');
    initData();
    Future.delayed(Duration(microseconds: 300), () {
      ChooseBorrowList(true, '');
    });
  }

  Future<void> ChooseBorrowList(bool isrefresh, String searchInput) async {
    String sql;
    String keynum;
    if(from=="borrow"){
      sql=" and udlocation='${location}' and uddqsyqty>0";
      keynum=Constants.GSJ_COMMON_ADD_LIST;
    }else{
      sql="and UDINVUSENUM='${num}' and USETYPE='UDJY' and STATUS='完成' and QUANTITY>nvl((select sum(QUANTITY) from UDINVUSELINE a where UDINVUSENUM='${num}' and USETYPE='UDGH' AND UDINVUSELINE.UDINVUSELINEID=a.udjyid),0)";
      keynum=Constants.GSJ_BORROW_BACK_LIST;
    }
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    LogD('getGsjList ${isrefresh} ');
    if (isrefresh) {
      startPage = Constants.START_PAGE;
      endPage = Constants.END_PAGE;
    }
    String option = Constants.READ;
    Map json = {
      "keyNum": keynum,
      "sqlWhere": sql,
      "sinorSearch": searchInput,
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

  void onRefresh() async {
    startPage = Constants.START_PAGE;
    endPage = Constants.END_PAGE;
    ChooseBorrowList(true, searchInput);
    _checkValue=false;
  }

  void onLoading() async {
    print("_onLoading======");
    startPage = endPage + 1;
    endPage = endPage + Constants.END_PAGE;
    ChooseBorrowList(false, searchInput);
  }

  void finishRefresh(bool refresh) {
    if (refresh) {
      refreshController.refreshCompleted();
    } else {
      refreshController.loadComplete();
    }
  }

  void search() {
    ChooseBorrowList(true, searchInput);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          _isOff
              ? IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  tooltip: "编辑",
                  onPressed: () {
                    if (agencyList.isNotEmpty) {
                      for (var index = 0; index < agencyList.length; index++) {
                        agencyList[index]['isSelected'] = false;
                      }
                    }
                    this.addList = []; //重置选中的ID数组
                    setState(() {
                      this._isOff = !this._isOff; //显示隐藏总开关
                      this._checkValue = false; //所以复选框设置为未选中
                      this._list = _list;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.clear_outlined,
                    color: Colors.grey,
                  ),
                  tooltip: "编辑",
                  onPressed: () {
                    if (agencyList.isNotEmpty) {
                      for (var index = 0; index < agencyList.length; index++) {
                        agencyList[index]['isSelected'] = false;
                        // Map _temp = {};
                        // _temp['id'] = index;
                        // _temp['select'] = false;
                        // _list.add(_temp);
                      }
                    }
                    // _list.forEach((f) {
                    //   f['select'] = false; //列表设置为未选中
                    // });
                    this.addList = []; //重置选中的ID数组
                    setState(() {
                      this._isOff = !this._isOff; //显示隐藏总开关
                      this._checkValue = false; //所以复选框设置为未选中
                      this._list = _list;
                    });
                  },
                ),
        ],
        title: Text(
          title,
          style:
              TextStyle(fontSize: TextSizeConfig.size20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                CommonSeachBar(
                    hint: hint,
                    hintSize: hintSize,
                    hintColor: hintColor,
                    icon: Icons.search,
                    onSearch: (e) {
                      searchInput = e.toString();
                      KeyBordUtil.hidekeybord(context);
                      print("搜索输出=====$e");
                      search();
                    }),
                Expanded(
                  child: !Constants.ISNETWORKAVAILABLE
                      ? GestureDetector(
                          onTap: onRefresh,
                          child: Image.asset("images/nonet.png",
                              fit: BoxFit.cover),
                        )
                      : noData
                          ? GestureDetector(
                              onTap: onRefresh,
                              child: Image.asset("images/nodata.png",
                                  fit: BoxFit.cover),
                            )
                          : SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: const WaterDropHeader(),
                              controller: refreshController,
                              onRefresh: onRefresh,
                              onLoading: onLoading,
                              child: listbuilder()),
                ),
              ],
            ),
            getItemBottom(),
          ],
        ),
      ),
    );
  }

  listbuilder() {
    LogD('agencyList=${agencyList.length}');
    return ListView.builder(
      itemBuilder: (context, index) {
        return _createGridViewItem(agencyList[index], index);
      },
        itemCount: agencyList.length,
    );
  }

  Widget _createGridViewItem(bean, int index) {
    return AnimationConfiguration.staggeredList(
        duration: const Duration(milliseconds: 800),
        position: index,
        child: SlideAnimation(
          verticalOffset: 50,
          child: FadeInAnimation(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 1),
              child: Container(
                child: Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Offstage(
                        offstage: _isOff,
                        child: Checkbox(
                          checkColor: Colors.white,
                          value: bean['isSelected'],
                          onChanged: (value) {
                            if (value == false) {
                              this.addList.remove(bean['uditemnum'].toString());
                              Map map={
                                "UDINVUSENUM":num,
                                "USETYPE":"UDJY",
                                "UDITEMNUM":bean['uditemnum'],
                                "DESCRIPTION":bean['uddescription'],
                                "FROMSTORELOC":location,
                                "UDDW":bean['udissueunit'],
                                "FROMLOT":bean['udlotnum'],
                              };
                              _list.remove(map);
                            } else {
                              this.addList.add(bean['uditemnum'].toString());
                              Map map={
                                "UDINVUSENUM":num,
                                "USETYPE":"UDJY",
                                "UDITEMNUM":bean['uditemnum'],
                                "DESCRIPTION":bean['uddescription'],
                                "FROMSTORELOC":location,
                                "UDDW":bean['udissueunit'],
                                "FROMLOT":bean['udlotnum'],
                              };
                              _list.add(map);
                            }
                            setState(() {
                              bean['isSelected'] = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //编码
                              CommonLightTextItem(
                                title: Constants.GSJ_ITEM_NO,
                                titlecolor: Colors.black,
                                titleSize: TextSizeConfig.size16,
                                content: bean["uditemnum"],
                                contentcolor: Colors.greenAccent,
                                contentSize: TextSizeConfig.size18,
                                searchInput: searchInput,
                                weight: FontWeight.bold,
                              ),

                              //描述
                              CommonLightTextItem(
                                title: Constants.GSJ_DESC,
                                titlecolor: Colors.black,
                                titleSize: TextSizeConfig.size16,
                                content: from=="borrow" ? bean["uddescription"]: bean["description"],
                                contentcolor: Colors.greenAccent,
                                contentSize: TextSizeConfig.size18,
                                searchInput: searchInput,
                                weight: FontWeight.normal,
                              ),
                              //仓库
                              CommonTextForm(
                                  title: Constants.STOREHOUSE,
                                  titlecolor: Colors.black,
                                  titleSize: TextSizeConfig.size16,
                                  content: bean["udlocation"],
                                  contentcolor: Colors.black,
                                  contentSize: TextSizeConfig.size16),

                              Row(
                                children: [
                                  //货位
                                  Expanded(
                                    child: CommonTextForm(
                                        title: Constants.PRODUCT_LOCTION,
                                        titlecolor: Colors.black,
                                        titleSize: TextSizeConfig.size16,
                                        content: bean["binname"],
                                        contentcolor: Colors.black,
                                        contentSize: TextSizeConfig.size16),
                                  ),
                                  //单位
                                  Expanded(
                                    child: CommonTextForm(
                                        title: Constants.UNIT,
                                        titlecolor: Colors.black,
                                        titleSize: TextSizeConfig.size16,
                                        content: bean["udissueunit"],
                                        contentcolor: Colors.black,
                                        contentSize: TextSizeConfig.size16),
                                  ),
                                ],
                              ),

                              //规格型号
                              CommonLightTextItem(
                                title: Constants.MODEL,
                                titlecolor: Colors.black,
                                titleSize: TextSizeConfig.size16,
                                content: bean["udmodel"],
                                contentcolor: Colors.greenAccent,
                                contentSize: TextSizeConfig.size18,
                                searchInput: searchInput,
                                weight: FontWeight.normal,
                              ),

                              //负荷
                              CommonLightTextItem(
                                title: Constants.WORK_LOAD,
                                titlecolor: Colors.black,
                                titleSize: TextSizeConfig.size16,
                                content: bean["udfh"],
                                contentcolor: Colors.greenAccent,
                                contentSize: TextSizeConfig.size18,
                                searchInput: searchInput,
                                weight: FontWeight.normal,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    //库存总量
                                    child: CommonTextForm(
                                        title: Constants.STORE_TOTAL,
                                        titlecolor: Colors.black,
                                        titleSize: TextSizeConfig.size16,
                                        content: bean["udcurbal"],
                                        contentcolor: Colors.black,
                                        contentSize: TextSizeConfig.size16),
                                  ),
                                  //当前剩余
                                  Expanded(
                                    child: CommonTextForm(
                                        title: Constants.CURRENT_COUNT,
                                        titlecolor: Colors.black,
                                        titleSize: TextSizeConfig.size16,
                                        content: bean["uddqsyqty"],
                                        contentcolor: Colors.black,
                                        contentSize: TextSizeConfig.size16),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  getItemBottom() {
    return Offstage(
      offstage: _isOff,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Container(
            height: 40,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _checkValue,
                      onChanged: (value) {
                        selectAll(value);
                      },
                    ),
                    Text(Constants.SELECT_ALL,style: TextStyle(
                        color: Colors.blue,
                        fontSize: TextSizeConfig.size16)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    child: Text(
                      Constants.CONFIRM,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: TextSizeConfig.size16),
                    ),
                    onTap: () {
                      LogD('_list=${_list}');
                      commit(_list);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void selectAll(value) {
    this._list = []; //要删除的数组ID重置
    agencyList.forEach((element) {
      element['isSelected'] = value;
      if (value == true) {
        //如果是选中，则将数据ID放入数组
        Map map={
          "UDINVUSENUM":num,
          "USETYPE":"UDJY",
          "UDITEMNUM":element['uditemnum'],
          "DESCRIPTION":element['uddescription'],
          "FROMSTORELOC":location,
          "UDDW":element['udissueunit'],
          "FROMLOT":element['udlotnum'],
        };
        _list.add(map);

      }
    });
    setState(() {
      _checkValue = value;
      agencyList = agencyList;
    });
  }

  Future<void> initData() async {
    title = Constants.CHOOSE_GSJ;
    hint = Constants.GSJ_LIST_HINT;
    name = await DataUtils.getString("loginname");
  }

  Future<void> commit(List<Map> list) async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.ADD;
    Map map = {
      "objectName": "UDINVUSE",
      "keyName": "UDINVUSENUM",
      "keyValue": num,
      "LineUDINVUSELINE":list,
    };

    try {
      Map<String, dynamic> resultMap =
          await DioClient.DioPost('${name}', option, map);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        // getGsjList(true);
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
}
