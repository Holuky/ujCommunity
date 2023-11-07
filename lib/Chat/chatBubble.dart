import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:intl/intl.dart';

class Message {
  String msg;
  String timeStamp;
  String sender;

  Message({
        required this.msg,
        required this.timeStamp,
        required this.sender
      });
}

class ChatBubbles extends StatelessWidget {
  ChatBubbles(this.message, this.isMe);

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe) ...{
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          message.timeStamp
                      ),
                        // style: TextStyle()
                      BubbleSpecialOne(
                        text: message.msg,
                        isSender: true,
                        color: Colors.blue,
                      ),
                    ]))
          },
          if (!isMe)
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*ProfileButton(
                          nickname: counselor.name,
                          path: counselor.profileUrl,
                          onProfilePressed: onProfilePressed),*/
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BubbleSpecialOne(
                                  text: message.msg,
                                  isSender: false,
                                  color: Colors.blue,
                                  //textStyle:,
                                ),
                                Text(
                                    DateFormat('yyyy/MM/dd')
                                        .format(
                                        DateTime.parse(message.timeStamp))
                                        .toString()
                                ),
                              ]
                          )
                      )
                    ]
                )
            )
        ]
    );
  }
}