import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Tabs.dart';

//有状态的
class CardViewPage extends StatefulWidget {
  final Map arguments;
  CardViewPage({Key key, this.arguments}) : super(key: key);

  @override
  _CardViewPageState createState() => new _CardViewPageState(arguments: this.arguments);
}

class _CardViewPageState extends State<CardViewPage> {

  Map arguments;
  _CardViewPageState({this.arguments});
  TextEditingController _privacyPwdController = new TextEditingController();
  TextEditingController _cardNoController;
  TextEditingController _descController;
  TextEditingController _pwdController;
  String _data = "暂无数据";
  String _dbName = 'ma.db'; //数据库名称
  var isDisplay = false;
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    print('视图${arguments}');
    isDisplay =  arguments['display'];
    _isButtonDisabled = false;
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
        automaticallyImplyLeading: true, //去掉返回按钮
        title: Text(
          "卡片信息",
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
              enabled: false,
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
              enabled: false,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Color(0xFF888888)),
              controller: _pwdController,
              obscureText: isDisplay ? false : true,
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
            Row(
              children: <Widget>[
                Expanded(child: RaisedButton(
                  
                    padding: new EdgeInsets.only(
                      bottom: 10.0,
                      top: 10.0,
                      left: 40.0,
                      right: 40.0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cardUpdate',arguments: arguments); 
                    },
                    child: Text(
                      "去修改",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                )),
                SizedBox(width: 10),
                Expanded(child: RaisedButton(
                    disabledColor: Colors.grey,
                    padding: new EdgeInsets.only(
                      bottom: 10.0,
                      top: 10.0,
                      left: 40.0,
                      right: 40.0,
                    ),
                    onPressed: _isButtonDisabled ? null : () {
                      showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                              return new AlertDialog(
                                  title: new Text('隐私密码'),
                                  content: new SingleChildScrollView(
                                      child: new ListBody(
                                          children: <Widget>[
                                              TextField(
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly,  //只允许输入数字
                                                  LengthLimitingTextInputFormatter(6)        //限制长度为6
                                                ],
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(color: Color(0xFF888888)),
                                                controller: _privacyPwdController,
                                                decoration: InputDecoration(
                                                  hintText: "请输入隐私密码",
                                                  hintStyle: TextStyle(color: Color(0xFF888888)),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                  border: OutlineInputBorder(
                                                    // borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                ),
                                              ),
                                          ],
                                      ),
                                  ),
                                  actions: <Widget>[
                                      new FlatButton(
                                          child: new Text('取消'),
                                          onPressed: () {
                                              Navigator.of(context).pop();
                                          },
                                      ),
                                      new FlatButton(
                                          child: new Text('确定'),
                                          onPressed: () async{
                                            var querySql = "SELECT * FROM privacy_table where id = 1";
                                            var result = await _query(_dbName,querySql);
                                            if (_privacyPwdController.text.toString() != result[0]['password'].toString()) {
                                              Fluttertoast.showToast(
                                                msg: "隐私密码错误！", backgroundColor: Colors.orange);
                                              return;
                                            }
                                            Navigator.of(context).pop();
                                            setState(() {
                                              isDisplay= true;
                                              _isButtonDisabled = true;
                                            });
                                            
                                          },
                                      ),
                                  ],
                              );
                          },
                      );
                    },
                    child: Text(
                      "查看卡密",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                )),
              ],
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

}


