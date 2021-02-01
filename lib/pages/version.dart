import 'package:flutter/material.dart';

//有状态的
class VersionPage extends StatefulWidget {
  VersionPage({Key key}) : super(key: key);

  @override
  _VersionPageState createState() => new _VersionPageState();
}

class _VersionPageState extends State<VersionPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    return Scaffold(
        appBar: AppBar(
          title: Text('版本信息'),
          backgroundColor: color,
        ),
        body: Column(
          children: <Widget>[
            Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Version 1.0',
                      softWrap: true,
                    ),
                    Text(
                      '个人自制学习的Flutter软件'
                      '功能包含注册、登录，时间规划、密码提示等',
                      softWrap: true,
                    ),
                  ]
                )
            )
          ],
        ),
      );
  }

  
}
