import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';


class MessagesStream extends StatelessWidget {
  MessagesStream({this.user});
  final user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Has Error");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          List<MessageBubble> msgWidgets = [];
          snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
            var msgText = data['text'];
            var msgSender = data['sender'];
            if(user==msgSender){
              print(user);
            }
            final msgWidget =
            MessageBubble(text: msgText, sender: msgSender,isMe: user==msgSender,);
            msgWidgets.add(msgWidget);
          }).toList().reversed;
          return Expanded(
            child: ListView(
              reverse: true,//displays everything from bottom
              padding: EdgeInsets.all(4.0),
              children: msgWidgets,
            ),
          );
        }
        return Text("No Data");
      },
    );
  }
}