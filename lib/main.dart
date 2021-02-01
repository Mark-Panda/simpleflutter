import 'package:flutter/material.dart';
// import './pages/startup.dart';
import './routers/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '启动页',
        debugShowCheckedModeBanner: false, //去掉DEBUG图标
        theme: new ThemeData(
            primarySwatch: Colors.deepOrange,
            primaryColor: Color.fromRGBO(255, 127, 102, 1.0)
        ),
        initialRoute: '/', //初始化时加载的路由
        onGenerateRoute: onGenerateRoute
    );
  }
}
