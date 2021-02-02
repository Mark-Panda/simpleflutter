import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

//有状态的
class PrivacyPwdPage extends StatefulWidget {
  PrivacyPwdPage({Key key}) : super(key: key);

  @override
  _PrivacyPwdPageState createState() => new _PrivacyPwdPageState();
}

class _PrivacyPwdPageState extends State<PrivacyPwdPage> {
  TextEditingController _oldPwdController = new TextEditingController();
  TextEditingController _newPwdController = new TextEditingController();
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
          "隐私密码设置",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,  //只允许输入数字
                LengthLimitingTextInputFormatter(6)        //限制长度为6
              ],
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _oldPwdController,
              decoration: InputDecoration(
                hintText: "原密码",
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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,  //只允许输入数字
                LengthLimitingTextInputFormatter(6)        //限制长度为6
              ],
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _newPwdController,
              decoration: InputDecoration(
                hintText: "新密码",
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
            Padding(padding: EdgeInsets.only(top: 30)),
            RaisedButton(
                onPressed: () async{
                  if (_oldPwdController.text == null || _oldPwdController.text == "") {
                    Fluttertoast.showToast(
                        msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  if (_newPwdController.text == null ||
                      _newPwdController.text == "") {
                    Fluttertoast.showToast(
                        msg: "插入数据不能为空！", backgroundColor: Colors.orange);
                    return;
                  }
                  var querySql = "SELECT * FROM privacy_table where id = 1";
                  var result = await _query(_dbName,querySql);
                  print('隐私密码查询结果${result[0]['password']}');
                  print('old密码${_oldPwdController.text}');
                  if (result[0]['password'].toString() != _oldPwdController.text.toString()){
                    Fluttertoast.showToast(
                        msg: "原始密码不正确！", backgroundColor: Colors.orange);
                    return;
                  }
                  if (result[0]['password'].toString() == _newPwdController.text.toString()){
                    Fluttertoast.showToast(
                        msg: "新密码不能与原始密码相同！", backgroundColor: Colors.orange);
                    return;
                  }
                  print('新密码${_newPwdController.text}');
                  var updateSql = "UPDATE privacy_table SET password = ? WHERE id = 1";
                  var updateResult = await _update(_dbName, updateSql, [_newPwdController.text]);
                  if (updateResult == 'true') {
                    Navigator.pushNamed(context, '/tabs',
                      arguments: {'index': 2});
                  }else {
                    Fluttertoast.showToast(
                        msg: "修改隐私密码失败,请重新尝试！", backgroundColor: Colors.orange);
                    return;
                  }
                },
                child: Text(
                  "点我修改",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )
            ),
            
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  ///查全部
  _query(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);
    var privacyInfo = await db.rawQuery(sql);
    await db.close();
    return privacyInfo;
  }

  ///改
  _update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql, arg); //修改条件，对应参数值
    await db.close();
    if (count > 0) {
      return 'true';
    } else {
      return 'false';
    }
  }

}
