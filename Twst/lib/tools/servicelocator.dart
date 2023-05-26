import 'package:get_it/get_it.dart';

import '../service/telandsmsservice.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerSingleton(TelAndSmsService());
}
