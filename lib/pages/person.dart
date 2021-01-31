import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

//有状态的
class PersonPage extends StatefulWidget {
  PersonPage({Key key}) : super(key: key);

  @override
  _PersonPageState createState() => new _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('我的获取主题${Theme.of(context).primaryColor}');
    Color color = Color.fromRGBO(255, 127, 102, 1.0);
    return MaterialApp(
      title: '大标题',
      home: Scaffold(
        appBar: AppBar(
          title: Text('我的标题'),
          backgroundColor: color,
        ),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            _LogoutBtn()
          ],
        ),
      ),
    );
  }

  _LogoutBtn() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              final result = await prefs.clear();
              if (result) {
                debugPrint('退出登录成功');
                
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null,
                );
              }
            },
            child: ListTile(
              leading: const Icon(Icons.outlined_flag),
              title: const Text('退出登录'),
            ),
          )
        ],
      ),
    );
  }
}
