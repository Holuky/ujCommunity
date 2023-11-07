
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chatRoom.dart';

class ChatRoomList extends StatefulWidget {
  ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  void ChangePageWithoutDuration(Widget _page) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => _page,
      transitionDuration: Duration(seconds: 0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).
        collection('ChatRooms').orderBy('timeStamp', descending: true).snapshots(),
        builder: (context, chatSnapShot) {
          return Scaffold(
              appBar: AppBar(
                  title: Text("채팅"),
                  centerTitle: true,
                  elevation: 0.0,
                  actions: [
                  ],
              ),
              body:
                  Container(
                    child: (chatSnapShot.connectionState == ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator(),)
                        : ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 150,
                          child: ListTile(
                            title: Text(chatSnapShot.data!.docs[index]['roomName']),
                            subtitle: ((chatSnapShot.data!.docs[index]['latestMessage']).toString().length >= 30)
                                ? Text((chatSnapShot.data!.docs[index]['latestMessage']).toString().substring(0, 30))
                                : Text((chatSnapShot.data!.docs[index]['latestMessage']).toString()),
                            leading: CircleAvatar(backgroundImage: Image.network('https://saigontechnology.com/assets/media/Blog/flutter-what-is-it.webp').image,),
                            hoverColor: Colors.red,
                            onTap: () {
                              ChangePageWithoutDuration(MainChatRoom(ChatRoomId: chatSnapShot.data!.docs[index]['chatRoomId'],));
                            },
                          ),
                        );
                      },
                      itemCount: chatSnapShot.data!.docs.length,
                    ),
                  ),
              );
        }
        );
  }


}