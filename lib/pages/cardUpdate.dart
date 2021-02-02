import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

//有状态的
class CardUpdatePage extends StatefulWidget {
  final Map arguments;
  CardUpdatePage({Key key, this.arguments}) : super(key: key);

  @override
  _CardUpdatePageState createState() =>
      new _CardUpdatePageState(arguments: this.arguments);
}

class _CardUpdatePageState extends State<CardUpdatePage> {
  Map arguments;
  _CardUpdatePageState({this.arguments});

  TextEditingController _cardNoController;
  TextEditingController _descController;
  TextEditingController _pwdController;
  String _data = "暂无数据";
  String _dbName = 'ma.db'; //数据库名称

  @override
  void initState() {
    super.initState();
    _cardNoController = new TextEditingController(text: arguments['cardNo']);
    _descController = new TextEditingController(text: arguments['title']);
    _pwdController = new TextEditingController(text: arguments['password']);
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "修改卡片",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              enabled: false, //只读
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _cardNoController,
              decoration: InputDecoration(
                hintText: "卡号",
                hintStyle: TextStyle(color: Color(0xFF888888)),
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                icon: Icon(Icons.card_travel),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _descController,
              decoration: InputDecoration(
                hintText: "描述",
                hintStyle: TextStyle(color: Color(0xFF888888)),
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                icon: Icon(Icons.message),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _pwdController,
              // obscureText: true,
              decoration: InputDecoration(
                hintText: "密码",
                hintStyle: TextStyle(color: Color(0xFF888888)),
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                icon: Icon(Icons.security),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            RaisedButton(
                padding: new EdgeInsets.only(
                  bottom: 10.0,
                  top: 10.0,
                  left: 50.0,
                  right: 50.0,
                ),
                onPressed: () {
                  if (_descController.text == null ||
                      _descController.text == "") {
                    Fluttertoast.showToast(
                        msg: "问题描述不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  if (_pwdController.text == null ||
                      _pwdController.text == "") {
                    Fluttertoast.showToast(
                        msg: "卡密信息不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  String sql =
                      "UPDATE card_table SET cardNo = ?, title = ?,password = ? WHERE id = ?";
                  _update(_dbName, sql, [
                    _cardNoController.text,
                    _descController.text,
                    _pwdController.text,
                    arguments['id']
                  ]);
                  Navigator.pushNamed(context, '/tabs',
                      arguments: {'index': 1});
                },
                child: Text(
                  "点我修改",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
            // RaisedButton(
            //   padding: new EdgeInsets.only(
            //       bottom: 10.0,
            //       top: 10.0,
            //       left: 50.0,
            //       right: 50.0,
            //     ),
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/tabs',arguments: {'index': 1});
            //     },
            //     child: Text(
            //       "取消",
            //       style: TextStyle(color: Colors.white, fontSize: 18),
            //     ),
            //     color: color,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     )
            // ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  ///改
  _update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql, arg); //修改条件，对应参数值
    await db.close();
    if (count > 0) {
      setState(() {
        _data = "更新数据库操作完成，该sql删除条件下的数目为：$count";
      });
    } else {
      setState(() {
        _data = "无法更新数据库，该sql删除条件下的数目为：$count";
      });
    }
  }

  ///增
  _add(String dbName, String sql) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("插入的卡片SQL：$path");

    // Database db = await openDatabase(path);
    // await db.transaction((txn) async {
    //   int count = await txn.rawInsert(sql);
    // });
    // await db.close();
  }
}
