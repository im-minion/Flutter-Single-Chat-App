import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_single_chat_app/main.dart';

class ChatScreen extends StatefulWidget {
  final String _clickedEmailId;

  ChatScreen(this._clickedEmailId);

  @override
  ChatScreenState createState() => new ChatScreenState(_clickedEmailId);
}

class ChatScreenState extends State<ChatScreen> {
  final String _clickedEmailId;

  ChatScreenState(this._clickedEmailId);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.pink),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(_clickedEmailId),
        ),
        body: new Text("abcd"),
      ),
    );
  }
}
