import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/tools/logutils.dart';
import 'package:twst/view/common_process_dialog.dart';

import '../bean/tabdatds.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import 'gsj_approve_list_page.dart';
import 'gsj_cjrecord_list_page.dart';
import 'gsj_detail_backpage.dart';
import 'gsj_detail_borrowpage.dart';
import 'gsj_detail_page.dart';

class GsjBorrowBackDetailPage extends StatefulWidget {
  final arguments;

  const GsjBorrowBackDetailPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => GsjBorrowBackDetailPageState();
}

class GsjBorrowBackDetailPageState extends State<GsjBorrowBackDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  late List<TabData> datas;
  late String name;
  late List<Map> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogD('arguments==${widget.arguments['data']}');

    datas = <TabData>[
      TabData(
          title: Constants.DETAIL,
          route: '',
          widget: GsjDetailPage(
            arguments: widget.arguments['data'],
          )),
      TabData(
          title: Constants.GSJ_BORROW,
          route: '',
          widget: GsjDetailBorrowPage(
            num: widget.arguments['data']['num'],
            location: widget.arguments['data']['fromstoreloc'],
            statue: widget.arguments['data']['status'],
          )),
      TabData(
          title: Constants.GSJ_BACK,
          route: '',
          widget: GsjDetailBackPage(
            num: widget.arguments['data']['num'],
            location: widget.arguments['data']['fromstoreloc'],
            statue: widget.arguments['data']['status'],
          )),
      TabData(
          title: Constants.GSJ_CJ_RECORD,
          route: '',
          widget: GsjCjRecordPage(
            num: widget.arguments['data']['num'],
          )),
      TabData(
          title: Constants.GSJ_APPROVE_LIST,
          route: '',
          widget: GsjApprovePage(
            num: widget.arguments['data']['num'],
            ownerId: widget.arguments['data']['ownerId'],
          )),
    ];
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: DefaultTabController(
        length: datas.length,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      _cj();
                    },

                    child: Image.asset("images/cj.png", width: 30,
                      height: 30,
                      color: Colors.black87,),
                  ),
                )
              ],
              // automaticallyImplyLeading: false,
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
              title: Text(Constants.GSJ_BORROW_BACK,
                  style: TextStyle(
                      color: Colors.black, fontSize: TextSizeConfig.size18)),
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                //未选中字体颜色
                labelColor: Colors.blue,
                //选中字体颜色
                unselectedLabelStyle:
                TextStyle(fontSize: TextSizeConfig.size16),
                //未选中字体大小
                labelStyle: TextStyle(
                    fontSize: TextSizeConfig.size18,
                    fontWeight: FontWeight.bold),
                //选中字体大小
                indicatorColor: Colors.blue,
                //指示器颜色
                //选中字体大小
                tabs: datas.map((TabData data) {
                  return Tab(
                    child: Text(
                      data.title,
                    ),
                    // icon: Icon(data.icon),
                  );
                }).toList(),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: datas.map((TabData data) {
                      return Padding(
                          padding: const EdgeInsets.all(5), child: data.widget);
                    }).toList(),
                  ),
                ),
                //完成状态下不显示按钮
                if( widget.arguments['data']['status'] != Constants.FINISHED )
                  InkWell(
                    onTap: _approve,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(Radius.circular(30)),
                        gradient: const LinearGradient(colors: <Color>[
                          Colors.black54, Colors.black87,
                        ]),
                      ),
                      height: 50,
                      child: Text(
                        //新建状态显示 发起流程  除此以外显示流程审批
                        widget.arguments['data']['status'] ==
                            Constants.ADD_NEW_ONE ?
                        Constants.START_PROCESS : Constants.APPROVE_PROCESS,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: TextSizeConfig.size20),
                      ),
                      // splashColor: Colors.green,

                    ),
                  ),
              ],
            )),
      ),
    );
  }

  void _approve() {
    // ToastUtils.shotToast('退出登录‘’‘’‘’‘’‘');
    // Navigator.pushNamed(context, '/mytest');
    if (widget.arguments['data']['status'] == Constants.ADD_NEW_ONE) {
     getGsjBorrowCount().then((int value){
       LogD('value() ==${value}');
       if (value == 0) {
         EasyLoading.showInfo('请选择借用工属具');
         return;
       }else{
         showDialog(context: context, builder: (BuildContext context) {
           return CommonProcessDialog(
             passCall: (e) {},
             objectName: "UDINVUSE",
             processName: "UDGSJJYGH",
             sqlWhere: "and UDINVUSENUM='${widget.arguments['data']['num']}'",
             flag: 1,
           );
         }
           ,);
       }
     });

    }else{
      showDialog(context: context, builder: (BuildContext context) {
        return CommonProcessDialog(
          passCall: (e) {},
          objectName: "UDINVUSE",
          processName: "UDGSJJYGH",
          sqlWhere: "and UDINVUSENUM='${widget.arguments['data']['num']}'",
          flag: 2,
        );
      }
        ,);
    }

  }

  _cj() async {
    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.UDJYCJ;
    Map map = {
      "objectName": "UDINVUSE",
      "keyName": "UDINVUSEID",
      "keyValue": '${widget.arguments['data']['udinvuseid']}',
    };
    list.add(map);

    try {
      Map<String, dynamic> resultMap =
      await DioClient.DioPost2('${name}', option, list);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        Navigator.of(context).pop();
      } else {
        EasyLoading.showToast(resultMap['msg']);
        DiaLogUtil.disMiss(context);
        // DiaLogUtil.disMiss(context);
      }
    } catch (e) {
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
    }
  }

  Future<void> initData() async {
    //登陆手机号
    name = await DataUtils.getString("loginname");
  }

  Future<int> getGsjBorrowCount() async {

    String option = Constants.READ;
    Map json = {
    "keyNum": Constants.GSJ_BORROW_BACK_LIST,
    "sqlWhere": " and UDINVUSENUM='${widget.arguments['data']['num']}' and USETYPE='UDJY' ",
    "sinorSearch": '',
    // "keysearch": "keyValue:1",
    "startRow": Constants.START_PAGE,
    "endRow": Constants.END_PAGE
    };
    try {
    Map<String, dynamic> resultMap =
    await DioClient.DioPost('${name}', option, json);
    if (resultMap['code'] == Constants.CODE_OK) {
    int total = int.parse(resultMap['total']);
    if (total > 0) {
    //有数据
    return total;
    } else {
    return 0;
    // ToastUtils.shotToast(Constants.NO_DATA);
    }
    } else {
    return 0;
    }
    } catch (e) {
    LogE(e.toString());
    return 0;

    }
  }
}
