import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../UsefulFunctions/UsefulFunctions.dart';

import 'CommentBoard.dart';

class Boardcontent extends StatefulWidget {
  Boardcontent(
      {required this.title,
      required this.content,
      required this.postId,
      required this.imgCnt,
      required this.publicKey});

  late String title;
  late String content;
  late String postId;
  late int imgCnt;
  late String publicKey;

  @override
  State<Boardcontent> createState() => _BoardcontentState();
}

class _BoardcontentState extends State<Boardcontent> {
  bool LikeIt = false;
  bool HateIt = false;
  late List<bool> isLiked;
  late Future myFuture;

  // comment
  TextEditingController _addComment = TextEditingController();

  @override
  void initState() {
    myFuture = getImagePath(widget.postId, widget.imgCnt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLiked = [LikeIt, HateIt];
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                (widget.imgCnt != 0) ?
                SizedBox(
                        height: 500,
                        width: 500,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: PageView.builder(
                              controller: PageController(
                                initialPage: 0,
                              ),
                              itemCount: widget.imgCnt,
                              itemBuilder: (BuildContext context, int index) {
                                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                  Fluttertoast.showToast(
                                      msg: '${widget.imgCnt} 개 있다고!!!!');
                                  return Container(
                                      child: Image.network(
                                        snapshot.data[index],
                                        fit: BoxFit.contain,
                                      ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }),
                        ),
                      )
                    : SizedBox.shrink(),

                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // width: MediaQuery.of(context).size.width  * 0.75,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                    child: ToggleButtons(
                      constraints: BoxConstraints(minWidth: 70, maxWidth: 170),
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.headphones),
                                Text('좋아요!'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.heart_broken),
                                Text('싫어요..'),
                              ],
                            ),
                          ),
                        ),
                      ],
                      isSelected: isLiked,
                      onPressed: (idx) {
                        setState(() {
                          if (idx == 0) {
                            if (LikeIt == false)
                              LikeIt = true;
                            else
                              LikeIt = false;

                            HateIt = false;
                          } else {
                            if (HateIt == false)
                              HateIt = true;
                            else
                              HateIt = false;

                            LikeIt = false;
                          }

                          setState(() {
                            isLiked = [LikeIt, HateIt];
                          });
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: OutlinedButton(
                      onPressed: () {
                        CreateChatRoom(widget.publicKey);
                      },
                      child: Text('이 게시물 작성자와 채팅을 시작할래요!!'),
                    ),
                  ),
                ),
                Expanded(child: CommentBoard(postId: widget.postId)),
              ]),
            );
          }),
    );
  }

  void CreateChatRoom(String counterpartId) async {
    var res = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ChatRooms')
        .doc(counterpartId)
        .get();

    if (res.data() == null) {
      String chatRoomId = getRandomPassword(32);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('ChatRooms')
          .doc(counterpartId)
          .set({
        'roomName': 'MyProfileName',
        'chatRoomId': chatRoomId,
        'timeStamp': Timestamp.now(),
        'latestMessage': '',
      });

      FirebaseFirestore.instance
          .collection('Users')
          .doc(counterpartId)
          .collection('ChatRooms')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'roomName': 'MyProfileName',
        'chatRoomId': chatRoomId,
        'timeStamp': Timestamp.now(),
        'latestMessage': '',
      });

      FirebaseFirestore.instance.collection('ChatRooms').doc(chatRoomId).set({
        'user1': FirebaseAuth.instance.currentUser!.uid,
        'user2': counterpartId,
      });

      FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(chatRoomId)
          .collection('Messages')
          .add({
        'user': 'user1',
        'msg': '당신의 첫 메시지를 입력해주세요!(지금 이 메시지는 상대방에게는 보이지 않습니다)',
        'timeStamp': Timestamp.now(),
      });
    }
  }

  Future<List<String>> getImagePath(String postId, int imgCnt) async {
    List<String> paths = [
      'https://www.fluttericon.com/logo_dart_192px.svg',
      'https://www.fluttericon.com/logo_dart_192px.svg',
      'https://www.fluttericon.com/logo_dart_192px.svg',
      'https://www.fluttericon.com/logo_dart_192px.svg'
    ];
    for (int idx = 0; idx < imgCnt; ++idx) {
      paths[idx] = await FirebaseStorage.instance
          .ref('/BoardImages/' + postId + '/' + idx.toString())
          .getDownloadURL();
    }
    return Future.delayed(const Duration(milliseconds: 50), () => paths);
  }
}
