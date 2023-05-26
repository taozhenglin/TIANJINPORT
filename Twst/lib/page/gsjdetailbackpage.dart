import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:twst/tools/logutils.dart';

import '../tools/colorutil.dart';

class GsjDetailBackPage extends StatefulWidget {
  final String num;
  const GsjDetailBackPage({Key? key, required this.num}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GsjDetailBackPageState();
  }
}

class GsjDetailBackPageState extends State<GsjDetailBackPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: const Icon(
        Icons.add_circle_rounded,
        color: Colors.greenAccent,
        size: 80,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: Container(
                        height: 100,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                ColorUtils.getRandomColor(),
                                ColorUtils.getRandomColor(),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            print('长按删除');
                          },
                          onTap: () {
                            LogD('点击了${index}');
                            Navigator.pushNamed(context, '/test');
                          },
                          child: Center(child: Text('${num}')),
                        ))),
              ),
            );
          },
        ),
      ),
    );
  }
}
