import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/tools/networkutil.dart';
import 'package:twst/view/common_search_bar.dart';

import '../service/constans.dart';
import '../tools/dialogutil.dart';
import '../tools/keybord.dart';
import '../view/common_appbar.dart';

class BaseListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseListPageState();
  }
}

class BaseListPageState extends State<BaseListPage> {
  late Widget appBarWidget; //body
  late String title = 'qqqq';
  late String hint = 'qqqq';
  late double hintSize = TextSizeConfig.size14;
  late Color hintColor = Colors.grey;
  late IconData icon;
  bool noData = false;
  late int startPage = Constants.START_PAGE;
  late int endPage = Constants.END_PAGE;
  late int total;
  late String searchInput = "";
  late bool isNetWorkAvailable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style:
              TextStyle(fontSize: TextSizeConfig.size18, color: Colors.black),
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
      body: Column(
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
                    child: Image.asset("images/nonet.png", fit: BoxFit.cover),
                  )
                : noData
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
      ),
    );
  }

  Future<void> initData() async {
    var netWorkAvailable = await NetWorkUtil.isNetWorkAvailable();
    print(netWorkAvailable);
    if (netWorkAvailable != 0) {
      //网络可用
      setState(() {
        Constants.ISNETWORKAVAILABLE = true;
      });
    } else {
      //网络不可用
      setState(() {
        Constants.ISNETWORKAVAILABLE = false;
        EasyLoading.showError('网络连接失败!');
        return;
      });
    }
  }

  closed() {
    // Navigator.of(context).pop();
  }

  void onRefresh() async {
    startPage = Constants.START_PAGE;
    endPage = Constants.END_PAGE;
  }

  void onLoading() async {
    print("_onLoading======");
    startPage = endPage + 1;
    endPage = endPage + Constants.END_PAGE;
  }

  void finishRefresh(bool refresh) {
    if (refresh) {
      refreshController.refreshCompleted();
    } else {
      refreshController.loadComplete();
    }
  }

  void search() {}

  listbuilder() {}
}

_lead() {}
