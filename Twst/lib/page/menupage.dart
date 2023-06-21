import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/tools/colorutil.dart';

import '../bean/tabdatds.dart';
import '../service/constans.dart';
import 'gsjgridpage.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MenuPageState();
  }
}

class _MenuPageState extends State {
  late List<TabData> datas;
  var randomColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = <TabData>[
      const TabData(
          title: '工属具管理', icon: Icons.build, route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '综合管理', icon: Icons.person, route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工单管理', icon: Icons.person, route: "/gsjtemporaryplanlist"),
    ];
    randomColor = ColorUtils.getRandomColor();
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
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 10,
            title: Text(Constants.APPBAR_FUNCTION,
                style: TextStyle(
                    color: Colors.black, fontSize: TextSizeConfig.size18)),
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey, //未选中字体颜色
              labelColor: Colors.lightBlue, //选中字体颜色
              unselectedLabelStyle:
                  TextStyle(fontSize: TextSizeConfig.size16), //未选中字体大小
              labelStyle: TextStyle(
                  fontSize: TextSizeConfig.size18, fontWeight: FontWeight.bold),
              indicatorColor: Colors.lightBlue, //指示器颜色
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
          body: TabBarView(
            children: datas.map((TabData tabview) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: CommonTabView(datas: datas, data: tabview),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CommonTabView extends StatefulWidget {
  final TabData data;
  final List<TabData> datas;
  const CommonTabView({Key? key, required this.data, required this.datas})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommonTabViewPage();
  }
}

class CommonTabViewPage extends State<CommonTabView> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.title != "工属具管理") {
      return Scaffold(
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 800),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: item(index),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return GsjGridView();

      // TODO: implement build
    }
  }

  item(int index) {
    return Container(
        height: 100,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            ColorUtils.getRandomColor(),
            ColorUtils.getRandomColor(),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/test');
          },
          child: Text('${index}'),
        ));
  }
}
