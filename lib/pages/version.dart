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
    return Scaffold(
      appBar: AppBar(
        title: Text('版本信息'),
        backgroundColor: color,
      ),
      body: Column(
        children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            ListTile(
              title: Text(
                '版本',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text(
                    '1.0',
                    style: TextStyle(fontSize: 16),
                  ), // icon-1
                ],
              ),
            ),
            ListTile(
              title: Text(
                '版本介绍',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              maxLines: 5,
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 15,
              ),
              controller: TextEditingController(
                text: "温馨小述：\n"
                "     本版本功能主要包括卡片密码管理(卡片账号,密码联想描述,密码)、隐私密码设置、个人信息设置。"
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
