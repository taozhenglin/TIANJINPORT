import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/service/constans.dart';
import 'package:twst/tools/logutils.dart';

import '../bean/tabdatds.dart';
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

class GsjBorrowBackDetailPageState extends State<GsjBorrowBackDetailPage> {
  late List<TabData> datas;

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
              ownerId:widget.arguments['data']['ownerId'],
          )),
    ];
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
                unselectedLabelColor: Colors.grey, //未选中字体颜色
                labelColor: Colors.blue, //选中字体颜色
                unselectedLabelStyle:
                    TextStyle(fontSize: TextSizeConfig.size16), //未选中字体大小
                labelStyle: TextStyle(
                    fontSize: TextSizeConfig.size18,
                    fontWeight: FontWeight.bold), //选中字体大小
                indicatorColor: Colors.blue, //指示器颜色
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
                        Constants.START_PROCESS,
                        style: TextStyle(
                            color: Colors.white, fontSize: TextSizeConfig.size20),
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
    Navigator.pushNamed(context, '/mytest');
  }
}