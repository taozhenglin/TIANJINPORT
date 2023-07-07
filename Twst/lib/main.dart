import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/rotes/rotes.dart';
import 'package:twst/tools/servicelocator.dart';

import 'login_page.dart';
import 'random_words.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Colors.white, // 状态栏背景色
      ));
  runApp(const MyApp());

  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // 不加这个强制横/竖屏会报错
  WidgetsFlutterBinding.ensureInitialized();
  // 注册服务
  setupLocator();
}

final GlobalKey<NavigatorState> gloableKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: gloableKey,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // primaryColor: Colors.white,
          ),
      home: const Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
