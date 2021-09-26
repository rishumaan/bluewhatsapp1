import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              sender.substring(0, sender.indexOf('@')),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            )
                : BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
            elevation: 5.0,
            color: isMe ? Color.fromRGBO(227, 254, 207, 10) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}