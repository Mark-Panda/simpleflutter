import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

List listData= [];

//有状态的
class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => new _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  String _data = "暂无数据";
  String _dbName = 'temp.db'; //数据库名称
  String _queryCards = 'SELECT * FROM card_table';

  @override
  void initState() {
    super.initState();
    _query(_dbName,_queryCards); //初始化查询出所有的卡片
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片管理'),
        automaticallyImplyLeading: false, //去掉返回按钮
        backgroundColor: color,
      ),
      body: CardListPage(),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: () async {
              Navigator.pushNamed(context, '/cardEdit');
            },
      ),
    );
  }


  //添加到数据库中
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

  ///查全部
  _query(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    listData = await db.rawQuery(sql);
    await db.close();
    setState(() {
      // print('所有的卡片${listData}');
      _data = "数据详情：$listData";
    });
  }

}


class CardListPage extends StatefulWidget {
  CardListPage({Key key}) : super(key: key);

  @override
  _CardListPageState createState() => new _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  @override
  Widget build(BuildContext context){
    Color color = Theme.of(context).primaryColor;
    return ListView(
        children: listData.map((value){

          return Slidable(
            actionPane: SlidableScrollActionPane(),//滑出选项的面板 动画
            actionExtentRatio: 0.25,
            child: Card(
              child: Column(
                children: <Widget>[
                  new Divider(),
                  ListTile(
                    leading: new Image.asset(
                        'images/cat.jpg', 
                        fit: BoxFit.contain
                      ) ,
                    title:Text(value["cardNo"]),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        Text(value["title"]), // icon-1
                      ],
                    ),
                    onTap: _ViewCardBtn(),
                  ),
                  new Divider(),
                  
                ]
              )
            ),
            secondaryActions: <Widget>[//右侧按钮列表
                IconSlideAction(
                    caption: '删除',
                    color: Colors.red,
                    icon: Icons.delete,
                    closeOnTap: false,
                    onTap: (){
                        // _showSnackBar('Delete');
                    },
                ),
            ],
          );
          
          // return Card(
          //   child: Column(
          //     children: <Widget>[
          //       new Divider(),
          //       ListTile(
          //         leading: new Image.asset(
          //             'images/cat.jpg', 
          //             fit: BoxFit.contain
          //           ) ,
          //         title:Text(value["cardNo"]),
          //         trailing: Wrap(
          //           spacing: 12, // space between two icons
          //           children: <Widget>[
          //             Text(value["title"]), // icon-1
          //           ],
          //         ),
          //         onTap: _ViewCardBtn(),
          //       ),
          //       new Divider(),
          //     ]
          //   )
          // );
        }).toList(),
      );
  }

  //查看卡片详情
  _ViewCardBtn() {

  }
}