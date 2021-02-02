import 'package:flutter/material.dart';
import '../pages/startup.dart';
import '../pages/home.dart';
import '../pages/cardManage.dart';
import '../pages/person.dart';
import '../pages/version.dart';
import '../pages/PersonalInformation.dart';
import '../pages/cardAdd.dart';
import '../pages/Tabs.dart';
import '../pages/cardUpdate.dart';
import '../pages/cardView.dart';
import '../pages/privacyPwd.dart';

//配置路由
final routers = {
  '/': (context) => StartupPage(),
  '/home': (context) => HomePage(), //底部导航对应的主页面
  '/cardManage': (context) => CardManagePage(),  //底部导航对应的卡片管理
  '/person': (context) => PersonPage(), //底部导航对应的个人中心
  '/version': (context) => VersionPage(),
  '/personalInformation': (context)=> PersonalInformationPage(),
  '/cardAdd': (context)=> CardAddPage(),
  '/cardUpdate': (context, {arguments})=> CardUpdatePage(arguments: arguments),
  '/cardView': (context, {arguments})=> CardViewPage(arguments: arguments),
  '/tabs': (context, {arguments})=> TabsPage(arguments: arguments),  //底部导航
  '/privacyPwd': (context) => PrivacyPwdPage(),   //设置隐私密码
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
