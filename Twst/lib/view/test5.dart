// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:twst/main.dart';
//
// class Test5 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: TestHomePage(url: "1111111"),
//     );
//   }
// }
//
// class TestHomePage extends StatefulWidget {
//   String url;
//
//   TestHomePage({Key? key, required this.url}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return TestHomePageState();
//   }
// }
//
// class TestHomePageState extends State<TestHomePage> {
//   InAppWebViewGroupOptions webOpptions = InAppWebViewGroupOptions(
//     crossPlatform: InAppWebViewOptions(
//       useShouldOverrideUrlLoading: true,
//       mediaPlaybackRequiresUserGesture: false,
//     ),
//     android: AndroidInAppWebViewOptions(
//       useHybridComposition: true,
//     ),
//     ios: IOSInAppWebViewOptions(
//       allowsInlineMediaPlayback: true,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       child: InAppWebView(
//         key: gloableKey,
//         initialFile: 'lib/view/webview.html',
//         initialOptions: webOpptions,
//       ),
//     );
//   }
// }
