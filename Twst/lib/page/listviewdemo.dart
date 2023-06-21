import 'package:flutter/material.dart';
import 'package:twst/tools/logutils.dart';

class Mytest extends StatefulWidget {
  @override
  _MytestState createState() => _MytestState();
}

class _MytestState extends State<Mytest> {
  List<Map> _list = []; //列表
  List<String> deleteIds = []; //要删除的ID数组
  bool _isOff = true; //相关组件显示隐藏控制，true代表隐藏
  bool _checkValue = false; //总的复选框控制开关

  //先初始化一些数据，当然这些数据实际中会调用接口的
  @override
  void initState() {
    super.initState();

    for (var index = 0; index <= 5; index++) {
      Map _temp = {};
      _temp['id'] = index;
      _temp['select'] = false;
      _list.add(_temp);
    }
    setState(() {
      _list = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的收藏'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: "编辑",
              onPressed: () {
                _list.forEach((f) {
                  f['select'] = false; //列表设置为未选中
                });
                this.deleteIds = []; //重置选中的ID数组
                setState(() {
                  this._isOff = !this._isOff; //显示隐藏总开关
                  this._checkValue = false; //所以复选框设置为未选中
                  this._list = _list;
                });
              },
            ),
          ],
        ), //这个是顶部tab样式，如果不需要可以去掉
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getItem(),
        ));
  }

  //主内容
  Widget getItem() {
    if (_list.isEmpty) {
      return Center(child: Text('暂无收藏'));
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            getItemContent(), //这里是列表的内容
            getItemBottom(), //这里是底部删除全选操作的内容
          ],
        ),
      );
    }
  }

  //底部操作样式
  Widget getItemBottom() {
    return Offstage(
      offstage: _isOff,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Container(
            height: 40,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _checkValue,
                      onChanged: (value) {
                        selectAll(value);
                      },
                    ),
                    Text('全选'),
                  ],
                ),
                InkWell(
                  child: Text('删除'),
                  onTap: () {
                    LogD('deleteIds=${deleteIds.asMap().values}');

                  },
                ),
              ],
            )),
      ),
    );
  }

  //底部复选框的操作逻辑
  selectAll(value) {
    this.deleteIds = []; //要删除的数组ID重置
    _list.forEach((f) {
      f['select'] = value;
      if (value == true) {
        //如果是选中，则将数据ID放入数组
        this.deleteIds.add(f['id'].toString());
        this.deleteIds.add(f['age'].toString());

        LogD('deleteIds=${deleteIds.asMap().keys}');
      }
    });
    setState(() {
      _checkValue = value;
      _list = _list;
    });
  }

  //列表
  Widget getItemContent() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _createGridViewItem(_list[index]);
      },
      itemCount: (_list == null) ? 0 : _list.length,
    );
  }

  //单个crad,这里可以自己定义一些样式
  Widget _createGridViewItem(item) {
    Color color = Colors.primaries[item['id']];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Container(
        height: 80,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Offstage(
              offstage: _isOff,
              child: Checkbox(
                value: item['select'],
                onChanged: (value) {
                  if (value == false) {
                    this.deleteIds.remove(item['id'].toString());
                  } else {
                    this.deleteIds.add(item['id'].toString());
                    this.deleteIds.add(item['age'].toString());
                  }
                  setState(() {
                    item['select'] = value;
                  });
                },
              ),
            ),
            Text('这里放内容'),
          ],
        ),
      ),
    );
  }
}
