import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationWdiget extends StatefulWidget {
  final int flag;
  final Widget child;
  final int duration;
  const AnimationWdiget(
      {Key? key,
      required this.flag,
      required this.child,
      required this.duration})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimationWdigetState();
  }
}

class AnimationWdigetState extends State<AnimationWdiget>
    with TickerProviderStateMixin {
  late AnimationController transController;
  late AnimationController scalController;
  late AnimationController colorController;
  late Animation<Offset> transmit;
  late Animation<double> scale;
  late Animation<Color> colorTween;
  late Animation color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //平移
    transController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    transmit = Tween(
      begin: Offset(0, 0.5),
      end: Offset(0, 0),
    ).animate(transController);
//缩放
    scalController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    scale = Tween(begin: 1.2, end: 1.0).animate(scalController);

    // colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
//颜色动画

    colorController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    color = ColorTween(begin: Colors.transparent, end: Colors.red)
        .animate(colorController);

    Future.delayed(Duration.zero, () {
      if (widget.flag == 1) {
        transController.forward();
      } else if (widget.flag == 2) {
        scalController.forward();
      } else {
        colorController.forward();
      }
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return buildBody();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scalController.dispose();
    transController.dispose();
    super.dispose();
  }

  Widget buildBody() {
    if (widget.flag == 1) {
      return SlideTransition(
        // width: transmit.value,
        // height: transmit.value,
        // position: transmit,
        position: transmit,
        child: widget.child,
      );
    } else if (widget.flag == 2) {
      return ScaleTransition(
        // width: transmit.value,
        // height: transmit.value,
        // position: transmit,
        scale: scale,
        child: widget.child,
      );
    } else {
      return Center(
        child: widget.child,
      );
    }
  }
}
