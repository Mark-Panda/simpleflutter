import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'message.dart';
import 'Tabs.dart';

//有状态的
class CardDetailPage extends StatefulWidget {
  CardDetailPage({Key key}) : super(key: key);

  @override
  _CardDetailPageState createState() => new _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  String _data = "暂无数据";
  String _dbName = 'temp.db'; //数据库名称

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "sqflite数据存储",
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
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "卡号",
                hintStyle: TextStyle(color: Color(0xFF888888)),
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _ageController,
              decoration: InputDecoration(
                hintText: "描述",
                hintStyle: TextStyle(color: Color(0xFF888888)),
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            RaisedButton(
              onPressed: () {
                if (_nameController.text == null || _nameController.text == "") {
                  Fluttertoast.showToast(
                      msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                  return;
                }
                if (_ageController.text == null || _ageController.text == "") {
                  Fluttertoast.showToast(
                      msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                  return;
                }
                String sql =
                    "INSERT INTO card_table(cardNo,title) VALUES('${_nameController.text}','${_ageController.text}')";
                _add(_dbName, sql);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TabsPage(arguments: { 'index': 2})));
              },
              child: Text(
                "插入数据",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Padding(padding: EdgeInsets.only(top: 30)),
            Text(
              _data,
              style: TextStyle(color: Colors.red, fontSize: 18),
            )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  _getNameInputView() {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(color: Color(0xFF888888)),
      controller: _nameController,
      decoration: InputDecoration(
        hintText: "姓名",
        hintStyle: TextStyle(color: Color(0xFF888888)),
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  _getAgeInputView() {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(color: Color(0xFF888888)),
      controller: _ageController,
      decoration: InputDecoration(
        hintText: "年龄",
        hintStyle: TextStyle(color: Color(0xFF888888)),
        contentPadding:
            EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  _getAddBtnView() {
    return RaisedButton(
        onPressed: () {
          if (_nameController.text == null || _nameController.text == "") {
            Fluttertoast.showToast(
                msg: "插入数据不能为空！", backgroundColor: Colors.orange);
            return;
          }
          if (_ageController.text == null || _ageController.text == "") {
            Fluttertoast.showToast(
                msg: "插入数据不能为空！", backgroundColor: Colors.orange);
            return;
          }
          String sql =
              "INSERT INTO student_table(name,age) VALUES('${_nameController.text}','${_ageController.text}')";
          _add(_dbName, sql);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(参数))).then((value) => _getInitial());
        },
        child: Text(
          "插入数据",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ));
  }

  

  

  

  ///增
  _add(String dbName, String sql) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径：$path");

    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();

    setState(() {
      _data = "插入数据成功！";
    });
  }

  

  

  
}
