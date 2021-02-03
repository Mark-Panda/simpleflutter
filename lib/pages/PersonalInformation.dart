import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//有状态的
class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => new _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {

  // Text _avatarController;
  String _nicknameController;
  String _birthdayController;
  String _ageController;
  String _personalsignatureController;

  String _dbName = 'ma.db'; //数据库名称
  Map userArgs;

  @override
  void initState(){
    super.initState();
    _query(_dbName);
    
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('个人资料'),
          backgroundColor: color,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/personEdit',arguments: userArgs).then((value){
                  setState(() {
                      _nicknameController = jsonDecode(value)['nickname'];
                      _birthdayController = jsonDecode(value)['birthday'];
                      _ageController = jsonDecode(value)['age'];
                      _personalsignatureController = jsonDecode(value)['personalsignature'];
                  });
                });
              },
            ),
          ],

        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 30)),
            ClipOval( //圆形头像
              child: new Image.asset(
                'images/cat.jpg', 
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            ListTile(
              title: Text('昵称'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text("$_nicknameController"), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('生日'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text("$_birthdayController"), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
              
            ),
            ListTile(
              title: Text('年龄'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text("$_ageController"), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('个人签名'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text("$_personalsignatureController"), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
              
            ),
          ],
        ),
      );
  }

  ///查全部
  _query(String dbName) async {
    var querySql = "SELECT * FROM user_table where id = 1";
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);
    var userInfo = await db.rawQuery(querySql);
    setState(() {
      _nicknameController = userInfo[0]['nickname'];
      _birthdayController = userInfo[0]['birthday'];
      _ageController = userInfo[0]['age'];
      _personalsignatureController = userInfo[0]['personalsignature'];
      userArgs = userInfo[0];
    });
    await db.close();
  }
  
}
