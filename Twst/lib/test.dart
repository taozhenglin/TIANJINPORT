import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "222222",
            style: TextStyle(color: Colors.green),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Expanded(child: new Image.asset('images/icon1.png')),
                  new Expanded(child: new Image.asset('images/icon2.png')),
                  new Expanded(child: new Image.asset('images/icon8.png')),
                ],
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  new Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  new Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                  ),
                  new Icon(
                    Icons.star,
                    color: Colors.grey,
                  )
                ],
              ),
              Text("zhejiushis1"),
              Text("zhejiushis1"),
              Text(
                "haha",
                style: TextStyle(
                    color: Colors.red, fontSize: 20, letterSpacing: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
