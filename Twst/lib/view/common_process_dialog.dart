import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../service/constans.dart';
import '../tools/approve.dart';
import '../tools/datautil.dart';
import 'common_dialog.dart';

class CommonProcessDialog extends StatefulWidget {
  /// 回调
  final Function(String str) passCall;

  final String objectName;

  final String sqlWhere;

  final String processName;

  final int flag;
  const CommonProcessDialog({Key? key, required this.passCall, required this.objectName, required this.processName,required this.sqlWhere,  required this.flag}) : super(key: key);

  @override
  _CommonProcessDialogState createState() => _CommonProcessDialogState();


}

class _CommonProcessDialogState extends State<CommonProcessDialog> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    DataUtils.getString('loginname').then((name) {
      if (mounted) {
        setState(() {
            userName = name;

        });
      }
    });
  }

  /// 输入框控制器
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.flag==1){
      return CommonDialog(
        onPressed: () {
          Navigator.of(context).pop('yes');
          goApprove(userName, widget.objectName, widget.processName,widget.sqlWhere, "", "", );
        }, warm: '是否启动工作流？',
      );
    }
    else{
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Constants.APPROVE_PROCESS,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0), child: Divider(color: Colors.black38)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MyButton(
                    src: "images/agree.jpg",
                    text: Constants.AGREE,
                    color: const Color(0xFF00C374),
                    onTap: () {
                      widget.passCall.call(_controller.text);
                      Navigator.pop(context);

                      if (_controller.text.isEmpty) {
                        goApprove(userName, widget.objectName, widget.processName,widget.sqlWhere, "Y", "同意", );
                      } else {
                        goApprove(userName, widget.objectName, widget.processName,widget.sqlWhere, "Y", _controller.text, );
                      }
                    },
                  ),
                  _MyButton(
                    src: "images/reject.jpg",
                    text: Constants.REJECTED,
                    color: const Color(0xFFF92200),
                    onTap: () {
                      widget.passCall.call(_controller.text);
                      Navigator.of(context).pop();
                      if (_controller.text.isEmpty) {
                        // EasyLoading.showInfo("${Constants.PLEASE_FILL_IN_THE_REJECTION_CONTENT}！");
                        goApprove(userName, widget.objectName, widget.processName,widget.sqlWhere, "N", "驳回", );
                      } else {
                        //Navigator.pop(context);

                        goApprove(userName, widget.objectName, widget.processName,widget.sqlWhere, "N", _controller.text, );
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  decoration:  InputDecoration(
                    hintText: "\n\n${Constants.PLEASE_FILL_IN_REMARKS}",
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.red,

                        ///设置边框的粗细
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

    }
  }
}

class _MyButton extends StatelessWidget {
  const _MyButton({Key? key, required this.src, required this.text, required this.color, this.onTap}) : super(key: key);

  /// 传入一个图片地址
  final String src;

  /// 按钮标题
  final String text;

  /// 按钮颜色
  final Color color;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Image(
              image: AssetImage(src),
              height: 20,
              width: 20,
            ),
            Text(text,
                style: const TextStyle(
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
