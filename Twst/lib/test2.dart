import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var container = Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 10, color: Colors.black38),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/car.png'),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 10, color: Colors.black38),
                    borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 10, color: Colors.black38),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/car.png'),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 10, color: Colors.black38),
                    borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/girl.png'),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return container;
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: const Text("这是一个gridview"),
    //   ),
    //   body: Center(
    //     child: gridView(),
    //   ),
    // );
  }

  Widget gridView() {
    // return GridView.extent(
    //   maxCrossAxisExtent: 150.0,
    //   padding: const EdgeInsets.all(4.0),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    //   children: _buildGridTitleList(13),
    // );
    // return GridView.count(
    //   padding: const EdgeInsets.all(4.0),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    //   crossAxisCount: 2,
    //   children: _buildGridTitleList(13),
    // );
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _buildGridTitleList(13).length,
      //禁止滑动
      // physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        return Programe(index);
      },
    );
  }

//构建item布局
  List<Widget> _buildGridTitleList(int count) {
    return List<Widget>.generate(
        count,
        (int index) =>
            // new Center(
            // child: new Column(
            //   children: [
            //     Image.asset('images/icon${index + 1}.png'),
            //     Text(
            //       '${index}',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 15,
            //       ),
            //     ),
            //   ],
            // ),
            // child: Image.asset('images/icon${index + 1}.png'),
            // ));
            Stack(
              alignment: const Alignment(0.6, 0.6),
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/icon${index + 1}.png'),
                  radius: 100.00,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black45),
                  child: Text(
                    '${index}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  Widget Programe(int index) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black12),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8.0)),
                ),
                margin: const EdgeInsets.all(4.0),
                child: _buildGridTitleList(13)[index],
              ),
            ),
            // Text("hahaha"),
          ],
        ),
      ),
    );
  }
}
