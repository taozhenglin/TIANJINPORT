import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/rotes/rotes.dart';

import 'login_page.dart';

class Test4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var container = Container(
      color: Colors.blue,
      width: 700,
      child: Column(
        children: [
          Image.network("http://images.xuejuzi.cn/1612/1_161207210503_1.jpg"),
          const Text(
            "haha",
            style: TextStyle(height: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );

    // return container;
    return MaterialApp(
      title: '',
      // theme: ThemeData(primaryColor: Colors.blue),
      onGenerateRoute: onGenerateRoute,
      home: Test4Page(
        title: 'hahahaha',
      ),
      //此处home可以直接由 / 替代
      // home: const Test4Page(
      //   title: 'hahahahah',
      // ),
    );
  }
}

class Test4Page extends StatefulWidget {
  final String title;

  const Test4Page({Key? key, required this.title}) : super(key: key);

// @override
//   _Test4PageState createState=> _Test4PageState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Test4PageState();
  }
}

class _Test4PageState extends State<Test4Page> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'you have changed the pic',
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('images/icon${_index}.png'),
              radius: 100.00,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.backup),
              onPressed: _decrementIndex,
              label: Text('上一张'),
            ),
            TextButton.icon(
                onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return NewPage(
                  //     text: '',
                  //   );
                  // }));

                  // var result = await Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return const newPage(
                  //     text: '我是第一个界面带过来的text',
                  //   );
                  // }));

                  //在路由注册表中已声明 new_page 所指代的页面
                  var result = await Navigator.pushReplacementNamed(
                    context,
                    "/login",
                  );
                  print('返回值=${result}');
                },
                icon: const Icon(Icons.call_missed_outgoing_sharp),
                label: const Text('进入下一个界面'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementIndex,
        tooltip: '下一张',
        child: const Icon(Icons.last_page_sharp),
      ),
    );
  }

  void _incrementIndex() {
    setState(() {
      _index++;
    });
  }

  void _decrementIndex() {
    setState(() {
      _index--;
    });
  }
}
