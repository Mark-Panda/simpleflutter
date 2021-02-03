import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//有状态的
class PersonEditPage extends StatefulWidget {
  final Map arguments;
  PersonEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _PersonEditPageState createState() => new _PersonEditPageState(arguments: this.arguments);
}

class _PersonEditPageState extends State<PersonEditPage> {

  Map arguments;
  _PersonEditPageState({this.arguments});

  // String _avatarController;
  String _nicknameController;
  String _birthdayController;
  String _ageController;
  String _personalsignatureController;

  String _dbName = 'ma.db'; //数据库名称

  @override
  void initState() {
    super.initState();
    // print('传来的参数$arguments');
    // _avatarController = new TextEditingController(text: arguments['cardNo']);
    _nicknameController = arguments['nickname'];
    _birthdayController = arguments['birthday'];
    _ageController = arguments['age'];
    _personalsignatureController = arguments['personalsignature'];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('资料编辑'),
          backgroundColor: color,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp),
            onPressed: () { 
              String resInfo = jsonEncode({'nickname': _nicknameController, 'birthday': _birthdayController, 'age': _ageController, 'personalsignature': _personalsignatureController});
                Navigator.of(context).pop(resInfo);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async{
                String sql =
                      "UPDATE user_table SET nickname = ?, birthday = ?,age = ?,personalsignature = ? WHERE id = 1";
                await _update(_dbName,sql,[
                  _nicknameController,
                  _birthdayController,
                  _ageController,
                  _personalsignatureController
                ]);
                String resInfo = jsonEncode({'nickname': _nicknameController, 'birthday': _birthdayController, 'age': _ageController, 'personalsignature': _personalsignatureController});
                Navigator.of(context).pop(resInfo);
                // Navigator.pushNamed(context, '/tabs',arguments: {'index': 2});
              },
            )
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
                  Text('$_nicknameController'), // icon-1
                  Icon(Icons.chevron_right), // icon-2
                ],
              ),
              onTap: (){
                Navigator.pushNamed(context, '/textEdit',arguments: {'message': _nicknameController, 'title': '昵称编辑'}).then((value){
                  print('回调信息$value');
                  setState(() {
                    _nicknameController = value;
                  });
                });
              }
            ),
            ListTile(
              title: Text('生日'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('$_birthdayController'), // icon-1
                  Icon(Icons.chevron_right), // icon-2
                ],
              ),
              onTap: (){
                DatePicker.showDatePicker(context,
                  // 是否展示顶部操作按钮
                  showTitleActions: true,
                  // 最小时间
                  minTime: DateTime(1900, 3, 5),
                  // 最大时间
                  maxTime: DateTime.now(),
                  // change事件
                  onChanged: (date) {
                    print('change $date');
                  },
                  // 确定事件
                  onConfirm: (date) {
                    print('confirm $date');
                    String year = date.year.toString();
                    String month = date.month.toString();
                    int age = DateTime.now().year - date.year;
                    if(date.month<=9){
                      month = "0" + month;
                    }
                    String day = date.day.toString();
                    if(date.day<=9){
                      day = "0" + day;
                    }
                    setState(() {
                      _birthdayController = year + '-' + month + '-' + day;
                      _ageController = age.toString();
                    });
                  },
                  // 当前时间
                  currentTime: DateTime.now(),
                  // 语言
                  locale: LocaleType.zh);
              }
            ),
            ListTile(
              title: Text('年龄'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('$_ageController'), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('个人签名'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('$_personalsignatureController'), // icon-1
                  Icon(Icons.chevron_right), // icon-2
                ],
              ),
              onTap: (){
                Navigator.pushNamed(context, '/textEdit',arguments: {'message': _personalsignatureController, 'title': '个人签名编辑'}).then((value){
                  setState(() {
                    _personalsignatureController = value;
                  });
                });
              }
            ),
          ],
        ),
      );
  }

  ///改
  _update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql, arg); //修改条件，对应参数值
    await db.close();
    
  }
  
  
}
