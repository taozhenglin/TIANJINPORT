import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/login_page.dart';
import 'package:twst/page/homepage.dart';
import 'package:twst/view/gsjtemporaryplanlist.dart';

import '../page/gsjcjlinelistpage.dart';
import '../view/GsjTemporaryPlanPage.dart';
import '../view/testpage.dart';

final routes = {
  '/homepage': (context, {arguments}) => HomePage(),
  '/login': (context, {arguments}) => LoginPage(),
  '/test': (context, {arguments}) => TestPage(),
  '/gsjtemporaryplanlist': (context, {arguments}) => GsjTemporaryPlanList(),
  '/baselistpage': (context, {arguments}) => GsjTemporaryPlanList(),
  '/gsj_temporary_plan': (context, {arguments}) =>
      GsjTemporaryPlanPage(arguments: arguments),
  '/gsj_cj_line': (context, {arguments}) => GsjCjLineListPage(
        arguments: arguments,
      ),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
