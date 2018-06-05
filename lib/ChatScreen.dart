import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_single_chat_app/main.dart';

class ChatScreen extends StatefulWidget {
  final String _clickedEmailId;
  final String userEmail, userId;

  ChatScreen(this._clickedEmailId, this.userEmail, this.userId);

  @override
  ChatScreenState createState() =>
      new ChatScreenState(_clickedEmailId, userEmail, userId);
}

class ChatScreenState extends State<ChatScreen> {
  final String _clickedEmailId;
  final String userEmail, userId;

  ChatScreenState(this._clickedEmailId, this.userEmail, this.userId);

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
