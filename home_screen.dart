import 'package:bluewhatsapp/screens/chat_list.dart';
import 'package:bluewhatsapp/screens/status_screen.dart';

import 'package:bluewhatsapp/screens/chat_list.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        var loggedInUser = user;
        print("user is :" + loggedInUser.email);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,

          title: Text(_auth.currentUser.email
              .substring(0, _auth.currentUser.email.indexOf('@'))),
          actions: <Widget>[
            Icon(Icons.search_outlined),
            Icon(Icons.more_vert_outlined),
            IconButton(
              icon: Icon(Icons.close),
              tooltip: 'Signout',
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              // Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Text('camera'),
            ChatList(),
            StatusScreen(),
            // CallsScreen(),
          ],
        ),
      ),
    );
  }
}