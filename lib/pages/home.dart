import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//有状态的
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageAState createState() => new _HomePageAState();
}

class _HomePageAState extends State<HomePage> {

    String _dbName = 'ma.db'; //数据库名称

    
    
    String _createPrivacyTableSQL =
        'CREATE TABLE privacy_table (id INTEGER PRIMARY KEY, name TEXT,password INTEGER)'; //创建隐私表;
    String _createCardTableSQL =
        'CREATE TABLE card_table (id INTEGER PRIMARY KEY, cardNo TEXT,title TEXT,password TEXT)'; //创建卡片表;
    String _createUserTableSQL =
        'CREATE TABLE user_table (id INTEGER PRIMARY KEY, avatar TEXT,nickname TEXT,birthday TEXT,age TEXT,personalsignature Text)'; //创建用户信息表;
    int _dbVersion = 1; //数据库版本

    @override
    void initState() {
      super.initState();
      //创建数据库、学生表
      _createDb(_dbName, _dbVersion, _createPrivacyTableSQL, _createCardTableSQL, _createUserTableSQL);
    }

    ///创建数据库db
  _createDb(String dbName, int vers, String privacyTable, String cardTable, String userTable) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径：$path数据库版本$vers");
    //打开数据库
    await openDatabase(path, version: vers,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //数据库升级,只回调一次
      print("数据库需要升级！旧版：$oldVersion,新版：$newVersion");
    }, onCreate: (Database db, int vers) async {
      //创建表，只回调一次
      await db.execute(privacyTable);
      await db.execute(userTable);
      var usersql = "INSERT INTO user_table(avatar,nickname,birthday,age,personalsignature) VALUES('','simple','保密','保密','这个人很懒,什么也没留下!')";
      await db.transaction((txn) async {
        int count = await txn.rawInsert(usersql);
      });
      await db.execute(cardTable);
      var sql = "INSERT INTO privacy_table(name,password) VALUES('root','111111')";
      await db.transaction((txn) async {
        int count = await txn.rawInsert(sql);
      });
      await db.close();
    });

    setState(() {
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);

    
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('使用手册'),
          automaticallyImplyLeading: false, //去掉返回按钮
          backgroundColor: color,
        ),
        body: Image.asset(
              'images/app.jpg',
              fit: BoxFit.cover,
            ),
        // body: Column(
        //   children: <Widget>[
        //     Image.asset(
        //       'images/app.jpg',
        //       width: 600,
        //       height: 240,
        //       fit: BoxFit.cover,
        //     ),
        //     titleSection,
        //     buttonSection,
        //     textSection,
        //   ],
        // ),
      );
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        /*3*/
        FavoriteWidget(),
        // Icon(
        //   Icons.star,
        //   color: Colors.red[500],
        // ),
        // Text('41'),
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
