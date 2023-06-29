import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  SplashPageState();
  }

}

class SplashPageState extends State<SplashPage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildma
    return Scaffold(

      body: Container(width:double.infinity,height:double.infinity,child: Image.asset('images/app_bg.jpg',fit: BoxFit.cover,width:double.infinity,height:double.infinity,)),
    );
  }

}