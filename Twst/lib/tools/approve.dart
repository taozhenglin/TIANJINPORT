
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twst/bean/eventbus.dart';

import '../service/constans.dart';
import '../service/dioclent.dart';

goApprove(String name, String objectName, String processName,String sqlWhere, String isPositive,
    String memo, ) async {
  Map map = {
    "objectName": objectName,
    "processname": processName,
    "sqlWhere": sqlWhere,
    "isPositive": isPositive,
    "memo": memo,

  };
  String option = Constants.APPROVE;
  try {
    Map<String, dynamic> resultMap =
        await DioClient.DioPost('${name}', option, map);
    if (resultMap['code'] == Constants.CODE_OK) {
      EasyLoading.showSuccess('${resultMap['msg']}');
      if(processName=="UDGSJJYGH"){
        //刷新大列表
        eventBus.fire(EventA(Constants.REFRESH_GSJ));
        //关闭界面
        eventBus.fire(EventA(Constants.CLOSE_PAGE));

      }
    } else {
      EasyLoading.showInfo('${resultMap['msg']}');
    }
  } catch (e) {

  }
}
