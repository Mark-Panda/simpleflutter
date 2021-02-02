import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Tabs.dart';

//有状态的
class CardAddPage extends StatefulWidget {
  CardAddPage({Key key}) : super(key: key);

  @override
  _CardAddPageState createState() => new _CardAddPageState();
}

class _CardAddPageState extends State<CardAddPage> {
  TextEditingController _cardNoController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  String _data = "暂无数据";
  String _dbName = 'ma.db'; //数据库名称

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "新增卡片",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
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
              obscureText: true,
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
                  if (_cardNoController.text == null ||
                      _cardNoController.text == "") {
                    Fluttertoast.showToast(
                        msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  if (_descController.text == null ||
                      _descController.text == "") {
                    Fluttertoast.showToast(
                        msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  String sql =
                      "INSERT INTO card_table(cardNo,title,password) VALUES('${_cardNoController.text}','${_descController.text}','${_pwdController.text}')";
                  _add(_dbName, sql);
                  Navigator.pushNamed(context, '/tabs',
                      arguments: {'index': 1});
                },
                child: Text(
                  "点我添加",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  ///增
  _add(String dbName, String sql) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("插入的卡片SQL：$path");

    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();
  }
}
