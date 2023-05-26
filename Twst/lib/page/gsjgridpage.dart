import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/config/textsize.dart';
import 'package:twst/tools/colorutil.dart';
import 'package:twst/tools/logutils.dart';

import '../bean/tabdatds.dart';
import '../view/common_updown_imagetext_item.dart';
import '../view/gsjtemporaryplanlist.dart';

class GsjGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GsjGridViewPage();
  }
}

class GsjGridViewPage extends State<GsjGridView> {
  late List<TabData> datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = <TabData>[
      const TabData(
          title: '工属具临时计划',
          icon: Icons.next_plan,
          image: "images/ls_plan.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具月计划',
          icon: Icons.calendar_month_sharp,
          image: "images/month_plan.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具年计划',
          icon: Icons.yard,
          image: "images/yearth_plan.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具到货验收',
          icon: Icons.transform,
          image: "images/ys.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具发放归还',
          icon: Icons.backup,
          image: "images/return.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具日检',
          icon: Icons.check,
          image: "images/day_check.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具周检',
          icon: Icons.weekend_rounded,
          image: "images/week_check.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具月检',
          icon: Icons.calendar_month_rounded,
          image: "images/month_check.png",
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具维修',
          icon: Icons.home_repair_service_outlined,
          image: 'images/repair.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具整改',
          icon: Icons.change_circle,
          image: 'images/zg.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具处置',
          icon: Icons.handyman_outlined,
          image: 'images/cz.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具档案管理',
          icon: Icons.home_repair_service_outlined,
          image: 'images/file.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具编码申请',
          icon: Icons.qr_code,
          image: 'images/code.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具包标准管理',
          icon: Icons.precision_manufacturing_sharp,
          image: 'images/gl.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具打包使用',
          icon: Icons.markunread_mailbox,
          image: 'images/db.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具台账',
          icon: Icons.menu,
          image: 'images/tz.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具库存',
          icon: Icons.store,
          image: 'images/kc.png',
          route: "/gsjtemporaryplanlist"),
      const TabData(
          title: '工属具盘点',
          icon: Icons.calculate,
          image: 'images/pd.png',
          route: "/gsjtemporaryplanlist"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnimationLimiter(
        child: GridView.count(
          padding: EdgeInsets.all(5),
          crossAxisCount: 3,
          // childAspectRatio: 1,
          // mainAxisSpacing: 10,
          // crossAxisSpacing: 10,
          children: List.generate(
            datas.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                    child: FadeInAnimation(
                        child: Center(
                  child: CommonUpDownImageTextItem(
                    icon: datas[index].icon!,
                    image: datas[index].image!,
                    text: datas[index].title,
                    imagecolor: ColorUtils.getRandomColor(),
                    onPressed: () {
                      LogD('${index}');
                      Navigator.pushNamed(context, '/gsjtemporaryplanlist');
                      // Navigator.pushNamed(context, datas[index].route);
                    },
                    textSize: TextSizeConfig.size16,
                    imageSize: 40,
                  ),
                ))),
              );
            },
          ),
        ),
      ),
    );
  }
}
