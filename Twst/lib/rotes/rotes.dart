import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twst/login_page.dart';
import 'package:twst/page/homepage.dart';
import 'package:twst/page/gsj_borrow_back_list.dart';

import '../page/gsj_cjline_listpage.dart';
import '../page/gsj_borrow_back_detail_page.dart';
import '../page/gsjtemporaryplanlist.dart';
import '../page/listviewdemo.dart';
import '../view/testpage.dart';

final routes = {
  '/homepage': (context, {arguments}) => HomePage(),
  '/login': (context, {arguments}) => LoginPage(),
  '/test': (context, {arguments}) => TestPage(),
  '/gsj_temporary_plan_list': (context, {arguments}) => GsjTemporaryPlanList(),
  '/gsj_borrow_back_list': (context, {arguments}) => GsjBorrowBackList(),
  '/gsj_borrow_back_detail': (context, {arguments}) =>
      GsjBorrowBackDetailPage(arguments: arguments),
  '/gsj_cj_line': (context, {arguments}) => GsjCjLineListPage(
        arguments: arguments,
      ),
  '/mytest': (context, {arguments}) => Mytest(
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
