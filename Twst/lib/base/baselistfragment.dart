import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../service/constans.dart';
import '../tools/networkutil.dart';
import '../view/common_search_bar.dart';

class BaseListFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseListFragmentState();
  }
}

class BaseListFragmentState extends State<BaseListFragment> with AutomaticKeepAliveClientMixin{
  bool noData = false;
  late int startPage = Constants.START_PAGE;
  late int endPage = Constants.END_PAGE;
  late int total;
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
      body: Column(
        children: [
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

  listbuilder() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
