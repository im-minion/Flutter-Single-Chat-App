import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

DatabaseReference chatDBReference =
FirebaseDatabase.instance.reference().child('chat');
DatabaseReference userDBReference =
FirebaseDatabase.instance.reference().child('users');

final Creference = FirebaseDatabase.instance.reference().child('chat');
final Ureference = FirebaseDatabase.instance.reference().child('users');

DatabaseReference mesageReference;

String message;
bool type = false;

class ChatScreen extends StatefulWidget {
  final String _clickedEmailId;
  final String userEmail, userId;
  final String secondUserId;

  ChatScreen(this._clickedEmailId, this.userEmail, this.userId,
      this.secondUserId);

  @override
  ChatScreenState createState() =>
      new ChatScreenState(_clickedEmailId, userEmail, userId, secondUserId);
}

class ChatScreenState extends State<ChatScreen> {
  final String _clickedEmailId;
  final String userEmail, userId;
  final String secondUserId;

  ChatScreenState(this._clickedEmailId, this.userEmail, this.userId,
      this.secondUserId);

  Future<Null> _function() async {
//TODO; find wich child exist A_B or B_A
//    print(userId);
//    print(secondUserId);
//
//    String key = await FirebaseDatabase.instance
//        .reference()
//        .child("chat")
//        .child(userId + "_" + secondUserId)
//        .key;
//    print(key);

//        .once()
//        .then((DataSnapshot snapshot) async {
//
//      StreamSubscription<Event> subscription = FirebaseDatabase.instance
//          .reference()
//          .child(userId + "_" + secondUserId)
//          .onValue
//          .listen((Event event) {
//
//      });

//    });
//    FirebaseAnimatedList list = new FirebaseAnimatedList(
//        query: FirebaseDatabase.instance.reference().child("users"),
//        itemBuilder:
//            (_, DataSnapshot snapshot, Animation<double> animation, int index) {
//          this.setState(() {
//
//          });
//        });
  }

  @override
  void initState() {
    super.initState();
    _function();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(primaryColor: Colors.pink),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(_clickedEmailId),
          ),
          body: new Stack(alignment: Alignment.bottomRight, children: <Widget>[
//            new FirebaseAnimatedList(
//              query: reference,
//              sort: (a, b) => b.key.compareTo(a.key),
//              padding: new EdgeInsets.all(8.0),
//              reverse: false,
//              itemBuilder: (_, DataSnapshot snapshot,
//                  Animation<double> animation, int index) {
//                print(snapshot.key);
//                return new ChatMessageRow(message, type);
//              },
//            )
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
