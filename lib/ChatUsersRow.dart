import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatUserRow extends StatelessWidget {
  final DataSnapshot snapshot;

  ChatUserRow(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width;
    return Center(
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
            Scaffold
                .of(context)
                .showSnackBar(new SnackBar(content: new Text(snapshot.value)));
          },
        ),
      ),
    );
  }
}
