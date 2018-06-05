import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_single_chat_app/ChatScreen.dart';

class ChatUserRow extends StatelessWidget {
  final DataSnapshot snapshot;
  final String userEmail, userId;

  ChatUserRow(this.snapshot, this.userEmail, this.userId);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width;
    return (snapshot.value != userEmail)? Center(
      child: new Container(
        width: itemWidth,
        alignment: Alignment.center,
        height: 36.0,
        child: new InkWell(
          child: new Text(
            snapshot.value,
            style: new TextStyle(fontSize: 18.0),
          ),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new ChatScreen(snapshot.value.toString())));
//            Scaffold
//                .of(context)
//                .showSnackBar(new SnackBar(content: new Text(snapshot.value)));
          },
        ),
      ),
    ):new Container();
  }
}
