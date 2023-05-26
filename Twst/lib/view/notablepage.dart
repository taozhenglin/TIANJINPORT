import 'dart:async';
import 'package:flutter/material.dart';

class NotablePage extends StatefulWidget {
  Widget child; // 轮播的内容
  Duration duration; // 轮播时间
  double stepOffset; // 偏移量
  double paddingLeft; // 内容之间的间距

  NotablePage(this.child, this.paddingLeft, this.duration, this.stepOffset);

  @override
  _NotablePageState createState() => _NotablePageState();
}

class _NotablePageState extends State<NotablePage> {
  late ScrollController _controller; // 执行动画的controller
  late Timer _timer; // 定时器timer
  double _offset = 0.0; // 执行动画的偏移量

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: _offset);

    WidgetsBinding widgetsBinding = WidgetsBinding.instance!;
    widgetsBinding.addPostFrameCallback((timeStamp) {
      _controller.animateTo(widget.stepOffset,
          duration: widget.duration, curve: Curves.linear);
    });

    _timer = Timer.periodic(widget.duration, (timer) {
      double newOffset = _controller.offset + widget.stepOffset;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration, curve: Curves.linear); // 线性曲线动画
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          List<Widget> items = [];
          for (var i = 0; i <= 2; i++) {
            Container item = Container(
              margin:
                  new EdgeInsets.only(right: i != 0 ? 0.0 : widget.paddingLeft),
              child: i != 0 ? null : widget.child,
            );
            items.add(item);
          }
          return Row(
            children: items,
          );
        });
  }
}
