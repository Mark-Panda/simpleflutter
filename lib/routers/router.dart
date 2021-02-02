import 'package:flutter/material.dart';
import '../pages/startup.dart';
import '../pages/login.dart';
import '../pages/home.dart';
import '../pages/message.dart';
import '../pages/category.dart';
import '../pages/person.dart';
import '../pages/version.dart';
import '../pages/PersonalInformation.dart';
import '../pages/cardDetail.dart';
import '../pages/Tabs.dart';
import '../pages/cardEdit.dart';

//配置路由
final routers = {
  '/': (context) => StartupPage(),
  '/home': (context) => HomePage(),
  '/category': (context) => CategoryPage(),
  '/message': (context, {arguments}) => MessagePage(),
  '/person': (context, {arguments}) => PersonPage(),
  '/version': (context) => VersionPage(),
  '/personalInformation': (context)=> PersonalInformationPage(),
  '/cardEdit': (context)=> CardDetailPage(),
  '/cardUpdate': (context, {arguments})=> CardEditPage(arguments: arguments),
  '/tabs': (context, {arguments})=> TabsPage(arguments: arguments),
};
//固定写法
var onGenerateRoute = (RouteSettings settings) {
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
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
