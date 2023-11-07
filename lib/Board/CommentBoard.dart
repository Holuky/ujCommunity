import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentBoard extends StatefulWidget {
  CommentBoard({required this.postId});
  late String postId;

  @override
  State<CommentBoard> createState() => _CommentBoardState();
}

class _CommentBoardState extends State<CommentBoard> {
  TextEditingController _addComment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 44,
                        child: TextField(
                          controller: _addComment,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '댓글을 작성해보세요',
                            // prefixIcon: Icon(Icons.search),
                          ),
                        )),
                  ),
                  OutlinedButton.icon(
                    onPressed: addComment,
                    icon: Icon(Icons.send),
                    label: Text(''),
                  )
                ],
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Board').doc(widget.postId).collection('Comments').orderBy('timeStamp').snapshots(),
                  builder: (context, chatSnapShot) {
                    return Container(
                        child: (chatSnapShot.connectionState == ConnectionState.waiting)
                            ? Center(child: CircularProgressIndicator(),)
                            : ListView.builder(
                            itemCount: chatSnapShot.data!.docs.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 70,

                                child: Card(
                                    child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),
                                            child: Container(
                                              child: Image.network('https://www.fluttericon.com/logo_dart_192px.svg',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(chatSnapShot.data!.docs[index]['user'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(chatSnapShot.data!.docs[index]['comment'],
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                          )
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              );
                            })
                    );
                  }),
            )
              ],
            ),
      )
    );
  }

  void addComment() {
    FirebaseFirestore.instance.collection('Board').
    doc(widget.postId).
    collection('Comments').add({
      'comment': _addComment.text,
      'timeStamp': Timestamp.now(),
      'user': FirebaseAuth.instance.currentUser!.uid,
    });

    _addComment.value = TextEditingValue.empty;
  }
}