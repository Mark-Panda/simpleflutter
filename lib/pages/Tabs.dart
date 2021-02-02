
import 'package:flutter/material.dart';
import 'home.dart';
import 'category.dart';
import 'cardManage.dart';
import 'person.dart';


//有状态的
class TabsPage extends StatefulWidget {
  final Map<String , num> arguments;

  TabsPage({Key key, this.arguments}) : super(key: key);
  
  @override
  _TabsPageState createState() => new _TabsPageState(arguments: this.arguments);
}


class _TabsPageState extends State<TabsPage> {

  Map arguments;
  _TabsPageState({this.arguments});

  int _currentIndex= 0;
  
  
  final List<Widget> _pageList = [
    
    HomePage(),
    CategoryPage(),
    CardManagePage(),
    PersonPage(),
  ];

  @override
  void initState() {
    super.initState();
    print('初始化arg${arguments}');
    _currentIndex = arguments['index'];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    print('argument${arguments['index']}');
    // _currentIndex = arguments['index'] ? arguments['index'] : _currentIndex;
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
              icon: Icon(Icons.credit_card),
              title: Text("卡密管理"),
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

