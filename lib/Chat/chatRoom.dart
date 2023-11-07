
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chatBubble.dart' as cb;

import 'chatClass.dart';

class MainChatRoom extends StatefulWidget {
  late String ChatRoomId;

  MainChatRoom({super.key, required this.ChatRoomId});

  @override
  State<MainChatRoom> createState() => _MainChatRoomState();
}

////////////////////////////// 사용자의 아이디 : 학번 + 고유번호 + s or p (s는 학생 p는 부모)
////////////////////////////// 고유번호는 4자리

class _MainChatRoomState extends State<MainChatRoom> {

  final TextEditingController _sendingText = TextEditingController();
  late bool isUser1;
  @override
  Widget build(BuildContext context) {
    int _limit = 50;
    identifyingUser1();
    return Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.
                collection('ChatRooms').
                doc(widget.ChatRoomId).
                collection('Messages').orderBy('timeStamp', descending: true).
                limit(_limit).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                          String formatData = '';//DateFormat('yyyy/MM/dd').format(snapshot.data!.docs[index]['timeStamp']);
                          return cb.ChatBubbles(
                              cb.Message(
                                  msg: snapshot.data!.docs[index]['msg'],
                                  timeStamp: formatData,
                                  sender: snapshot.data!.docs[index]['user']
                              ), true
                          );
                        },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }

            )
          ),


          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 44,
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          SendMessage();
                        },
                        controller: _sendingText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term',
                          prefixIcon: Icon(Icons.search),
                        ),
                        autofocus: true,
                      )),
                ),

                OutlinedButton.icon(
                  onPressed: SendMessage,
                  icon: Icon(Icons.telegram_outlined),
                  label: Text(''),
                )
              ],
            ),
          )
        ]
    );
  }

  void identifyingUser1() async {
    var current = await FirebaseFirestore.instance.
    collection('ChatRooms').
    doc(widget.ChatRoomId).get();

    if(current.data()!['user1'] == FirebaseAuth.instance.currentUser!.uid)
      isUser1 = true;
    else
      isUser1 =  false;
  }

  void SendMessage() {
    FirebaseFirestore.instance.collection('ChatRooms').
    doc(widget.ChatRoomId).
    collection('Messages').add({
      'msg': _sendingText.text,
      'timeStamp': DateTime.now(),
      'user': (isUser1 == true) ? ('user1') : ('user2'),
    });
    _sendingText.value = TextEditingValue.empty;
  }
}


/*

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chatBubble.dart' as cb;

import 'chatClass.dart';

class MainChatRoom extends StatefulWidget {
  late String ChatRoomId;

  MainChatRoom({super.key, required this.ChatRoomId});

  @override
  State<MainChatRoom> createState() => _MainChatRoomState();
}

////////////////////////////// 사용자의 아이디 : 학번 + 고유번호 + s or p (s는 학생 p는 부모)
////////////////////////////// 고유번호는 4자리

class _MainChatRoomState extends State<MainChatRoom> {

  final TextEditingController _sendingText = TextEditingController();
  late bool isUser1;
  @override
  Widget build(BuildContext context)
  {
    int _limit = 50;
    identifyingUser1();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.
      collection('ChatRooms').
      doc(widget.ChatRoomId).
      collection('Messages').orderBy('timeStamp', descending: true).
      limit(_limit).snapshots(),
      builder: (context, snapshot) {
        cb.Message msg = cb.Message(msg: '', timeStamp: '' ,sender: '');
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: Column(
                    children : [
                      cb.ChatBubbles(msg, true),
                    ],
                ),
              ),


              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 44,
                          child: TextField(
                            controller: _sendingText,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a search term',
                              prefixIcon: Icon(Icons.search),
                            ),
                          )),
                    ),

                    OutlinedButton.icon(
                      onPressed: SendMessage,
                      icon: Icon(Icons.telegram_outlined),
                      label: Text(''),
                    )
                  ],
                ),
              )
            ]
          );
        }
      },
    );
  }

  void identifyingUser1() async {
    var current = await FirebaseFirestore.instance.
    collection('ChatRooms').
    doc(widget.ChatRoomId).get();

    if(current.data()!['user1'] == FirebaseAuth.instance.currentUser!.uid)
      isUser1 = true;
    else
      isUser1 =  false;
  }

  void SendMessage() {
    FirebaseFirestore.instance.collection('ChatRooms').
    doc(widget.ChatRoomId).
    collection('Messages').add({
      'msg': _sendingText.text,
      'timeStamp': Timestamp.now(),
      'user': (isUser1 == true) ? ('user1') : ('user2'),
    });
    _sendingText.value = TextEditingValue.empty;
  }
}
*/