import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'version.dart';

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
    Color color = Theme.of(context).primaryColor;
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    return Scaffold(
        appBar: AppBar(
          title: Text('个人中心'),
          automaticallyImplyLeading: false,
          backgroundColor: color,
        ),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            _LogoutBtn(),
            Padding(padding: EdgeInsets.only(top: 10)),
            // _VersionViewBtn(),
          ],
        ),
      );
  }

  //退出登录
  _LogoutBtn() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, '/personalInformation');
            },
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('个人资料'),
            ),
          ),
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
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, '/version');
            },
            child: ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('版本信息'),
            ),
          )
        ],
      ),
    );
  }

  //版本信息查看
  _VersionViewBtn() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              // Navigator.pushNamed(context, '/version',arguments: {});
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VersionPage()),
                );
            },
            child: ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('版本信息'),
            ),
          )
        ],
      ),
    );
  }

}
