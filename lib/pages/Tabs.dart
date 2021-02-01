
import 'package:flutter/material.dart';
import 'home.dart';
import 'category.dart';
import 'message.dart';
import 'person.dart';


//有状态的
class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => new _TabsPageState();
}


class _TabsPageState extends State<TabsPage> {

  int _currentIndex=0;
  final List<Widget> _pageList = [
    
    HomePage(),
    CategoryPage(),
    MessagePage(),
    PersonPage(),
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    print('Tabs 主题色${color}');
    return Scaffold(
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
            setState(() {  //改变状态
              this._currentIndex=index;
            });
          },
          iconSize: 35,  //icon大小
          fixedColor: color,  //选中的颜色
          type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮，不设置多余3个会被挤下来
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("首页"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("分类"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text("资讯"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("我的"),
            ),
          ],
        ),
      );
    }

    
}

