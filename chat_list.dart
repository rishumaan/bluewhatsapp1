import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import './chat_room.dart';

final _chatData = List<Map<String, Object>>.generate(1, (int index) {
  return {
    'avatar': Icon(Icons.person),
    'name': 'Contact ${index + 1}',
    'lastMessage': 'hi there',
    'lastSeen': '2:50 pm',
  };
});

class ChatItem {
  final Icon avatar;
  final String name;
  final String lastMessage;
  final String lastSeen;

  ChatItem.fromData(data)
      : this.avatar = data['avatar'],
        this.name = data['name'],
        this.lastMessage = data['lastMessage'],
        this.lastSeen = data['lastSeen'];
}

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ChatListState extends State<ChatList> {
  void messageStreams() async {
    await for (var snapshot in _firestore.collection('contacts').snapshots()) {
      for (var msg in snapshot.docs)
        print(msg.data().values);
    }
    print("done");
  }

  @override
  void initState() {
    super.initState();

    messageStreams();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _chatData.length,
      itemBuilder: (BuildContext context, int index) {
        final chatItem = ChatItem.fromData(_chatData[index]);
        final avatarRadius = 25.0;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return ChatRoom(chatItem);
              }),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  radius: avatarRadius,
                  child: chatItem.avatar,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              chatItem.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Text(
                            chatItem.lastSeen,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          chatItem.lastMessage,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}