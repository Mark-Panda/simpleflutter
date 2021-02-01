import 'dart:async';

import 'package:flutter/material.dart';
import 'login.dart';
import 'Tabs.dart';

class StartupPage extends StatefulWidget {
  StartupPage({Key key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  Timer timer;
  num index = 0;
  @override
  void initState() {
    // TODO: implement initState
    startTimeout();
    super.initState();
  }

  //设置跳转时间，时间过后执行回调函数
  startTimeout() {
    const timeout = const Duration(seconds: 2); //跳转时间
    timer = Timer(timeout, handleTimeout);
  }

  //回调函数，路由跳转界面
  handleTimeout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TabsPage(arguments: {
              "index": index
            }
          )
      ),
      // MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => route == null,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      backgroundColor: Theme.of(context).primaryColor, //与背景图片的颜色，取得色
      body: new Center(
          child: new Image.asset('images/eat.jpg', fit: BoxFit.cover)),
    );
  }
}
