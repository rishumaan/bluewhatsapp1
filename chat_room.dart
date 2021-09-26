

import 'package:bluewhatsapp/components/message_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_list.dart';

class ChatRoom extends StatefulWidget {
  final ChatItem chatItem;
  ChatRoom(this.chatItem);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}
var loggedInUser;
class _ChatRoomState extends State<ChatRoom> {
  String messageText;
  final messageTextCont=TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("user is :" + loggedInUser.email);
      }
    } on FirebaseAuthException catch (e) {

      print(e);
    }
  }
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final roundedContainer = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(

        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(width: 8.0),
            Icon(Icons.insert_emoticon,
                size: 30.0, color: Theme.of(context).hintColor),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: messageTextCont,
                onChanged: (value) {
                  messageText = value;
                },
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.attach_file,
                size: 30.0, color: Theme.of(context).hintColor),
            SizedBox(width: 8.0),
            Icon(Icons.camera_alt,
                size: 30.0, color: Theme.of(context).hintColor),
            SizedBox(width: 8.0),
          ],
        ),
      ),
    );

    final inputBar = Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: roundedContainer,
          ),
          SizedBox(
            width: 5.0,
          ),
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.teal,
              child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.white,
                //Send messages to firebase
                onPressed: () {
                  messageTextCont.clear();
                  _firestore.collection('messages').add({
                    'text': messageText,
                    'sender': _auth.currentUser.email,
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );    final avatarRadius = 20.0;

    final scaffold = Scaffold(
      backgroundColor: Color(0xFFECE5DD),
      // backgroundColor: Color.fromRGBO(227, 254, 207, 10),
      appBar: AppBar(
        leadingWidth: 20,
        backgroundColor: Colors.teal,
        title: SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  radius: avatarRadius,
                  child: widget.chatItem.avatar,
                ),
              ),
              Positioned(
                left: 50,
                top: 10,
                child: Text(widget.chatItem.name),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          MessagesStream(user: _auth.currentUser.email),
          inputBar,
        ],
      ),
    );

    return SafeArea(
      top: false,
      bottom: true,
      child: scaffold,
    );
  }
}
