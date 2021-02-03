import 'package:flutter/material.dart';

//有状态的
class TextEditPage extends StatefulWidget {
  final Map arguments;
  TextEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _TextEditPageState createState() => new _TextEditPageState(arguments: this.arguments);
}

class _TextEditPageState extends State<TextEditPage> {

  Map arguments;
  _TextEditPageState({this.arguments});

  // String _messageController;
  String _titleController;
  TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = new TextEditingController(text: arguments['message']);
    _titleController = arguments['title'];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('$_titleController'),
          backgroundColor: color,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp),
            onPressed: () { 
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.of(context).pop(_messageController.text);
              },
            )
          ],
        ),
        body: TextField(
              keyboardType: TextInputType.text,
              controller: _messageController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              ),
        )
      );
  }

  
  
}
