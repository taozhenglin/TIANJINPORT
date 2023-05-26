import 'package:connectivity/connectivity.dart';

class NetWorkUtil {
  ///判断网络是否可用
  ///0 - none | 1 - mobile | 2 - WIFI
  static Future<int> isNetWorkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return 1;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 2;
    } else if (connectivityResult == ConnectivityResult.none) {
      return 0;
    }
    return 3;
  }
}
