import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestPageState<TestPage>();
  }
}

class _TestPageState<TestPage> extends State {
  @override
  Widget build(BuildContext context) {
    int columnCount = 3;

    return Scaffold(
      appBar: AppBar(
        leading: lead(),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          '工属具管理',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: AnimationLimiter(
        child: GridView.count(
          padding: EdgeInsets.all(5),
          crossAxisCount: columnCount,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(
            20,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: columnCount,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: ListChild(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ListChild() {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
      child: Row(
        children: [
          Image.asset(
            "images/car.png",
          ),
        ],
      ),
    );
  }

  lead() {
    // Navigator.pop(context);
  }
}
