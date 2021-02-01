import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Tabs.dart';

//有状态的
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  

  @override
  void initState() {
    //监听输入改变
    _unameController.addListener(() {
      // print('实时监听用户名输入框');
      // print(_unameController.text);
    });
    //监听输入改变
    _pwdController.addListener(() {
      // print('实时监听密码输入框');
      // print(_pwdController.text);
    });
  }

  _login(name, pwd) async {
    try {
      // await _getToken(name);
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('user_token') ?? '';
      if(token == ''){
        token = await _getToken(name);
      }
      print('Toen为${token}');
      var url = 'http://localhost:7001/login';
      Response response;
      Dio dio = new Dio();
      response = await dio.post(url,
          data: {'email': name, 'isOnline': true, 'password': pwd},
          options: Options(
            headers: {
              'Authorization': token
            },
            receiveTimeout: 2
          )
        );

      print('登录返回结果 ${response.data['code']}');
      if (response.data['code'] == 200) {
        Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => TabsPage()));
      }else {
        Fluttertoast.showToast(
                msg: "登录失败，请重新登录！", backgroundColor: Colors.orange);
      }
      
      // print('Response body: ${response.body}');
    } catch (e) {
      print('错误信息${e}');
      Fluttertoast.showToast(
                msg: "登录失败，请重新登录！", backgroundColor: Colors.orange);
      // Navigator.pushNamed(context, '/home');
    }
  }
 
  //获取token
  _getToken(String name) async {
    try {
      print('token start');
      var url = 'http://localhost:7001/takeToken';
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          url,
          data: {'email': name},
          options: Options(
            headers: {
              'Content-Type': 'application/json'
            },
            receiveTimeout: 2
          )
          );
      print('登录返回结果Token ${response.data}');
      Map<String, Object> data = response.data;
      final prefs = await SharedPreferences.getInstance();
      final setTokenResult = await prefs.setString('user_token','Bearer ' + data['msg']);
      if(setTokenResult){
          print('保存登录token成功');
          return 'Bearer ' + data['msg'];
      }else{
          Fluttertoast.showToast(
                msg: "获取token失败！", backgroundColor: Colors.orange);
      }
    } catch (e) {
      print('错误信息${e}');
      Fluttertoast.showToast(
                msg: "获取token失败！", backgroundColor: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    Color color = Theme.of(context).primaryColor;
    print('登录的主题颜色${color}');
    return Scaffold(
      appBar: AppBar(
        title: Text("注册或登录"),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  cursorColor: color,  //光标颜色
                  controller: _unameController,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),  //下划线颜色
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),  //下划线颜色
                      labelText: "用户名",
                      labelStyle: TextStyle(
                        color: color,
                      ),
                      hintText: "用户名或邮箱",
                      hintStyle: TextStyle(
                        color: color,
                      ),
                      icon: Icon(Icons.person, color: color)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  cursorColor: color,  //光标颜色
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
                      labelText: "密码",
                      labelStyle: TextStyle(
                        color: color,
                      ),
                      hintText: "您的登录密码",
                      hintStyle: TextStyle(
                        color: color,
                      ),
                      icon: Icon(Icons.lock, color: color)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 0 ? null : "密码不能少于1位";
                  }),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                        child: Builder(builder: (context) {
                      return RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: color,
                        textColor: Colors.white,
                        onPressed: () {
                          //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                          if (Form.of(context).validate()) {
                            //验证通过提交数据
                            print('用户名 ${_unameController.text}');
                            print('密码 ${_pwdController.text}');
                            _login(_unameController.text, _pwdController.text);
                          }
                        },
                      );
                    }))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
