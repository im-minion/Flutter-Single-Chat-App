import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_single_chat_app/main.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

DatabaseReference chatReference =
    FirebaseDatabase.instance.reference().child('chat');
DatabaseReference userReference =
    FirebaseDatabase.instance.reference().child('users');

final reference = FirebaseDatabase.instance.reference();

String message, secondUserId;
bool type = false;

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
//
//  Future<Null> _function() async {
//    var ref = FirebaseDatabase.instance.reference().child('users');
//    // print(ref.toString());
//
//    this.setState(() {});
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _function();
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(primaryColor: Colors.pink),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(_clickedEmailId),
          ),
          body: new Stack(alignment: Alignment.bottomRight, children: <Widget>[
            new FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                print(snapshot.key);
                return new ChatMessageRow(message, type);
              },
            )
          ]),
        ));
  }
}

class ChatMessageRow extends StatefulWidget {
  final String message;
  final bool type;

  ChatMessageRow(this.message, this.type);

  @override
  ChatMessageRowState createState() => new ChatMessageRowState(message, type);
}

class ChatMessageRowState extends State<ChatMessageRow> {
  final String message;
  final bool type;

  ChatMessageRowState(this.message, this.type);

  @override
  Widget build(BuildContext context) {
    return type ? new Text("aaa") : new Text("bbbb");
  }
}
