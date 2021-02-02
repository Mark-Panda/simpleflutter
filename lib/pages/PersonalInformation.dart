import 'package:flutter/material.dart';

//有状态的
class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => new _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // Color color = Color.fromRGBO(255, 127, 102, 1.0);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('个人资料'),
          backgroundColor: color,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],

        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 30)),
            ClipOval( //圆形头像
              child: new Image.asset(
                'images/cat.jpg', 
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            ListTile(
              title: Text('昵称'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('simple'), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('生日'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('11-21'), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('年龄'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('20'), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
            ListTile(
              title: Text('个人签名'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Text('20'), // icon-1
                  // Icon(Icons.chevron_right), // icon-2
                ],
              ),
            ),
          ],
        ),
      );
  }

  
  
}
