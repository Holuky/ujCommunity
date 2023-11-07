
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


import 'pickImgMobile.dart'
if (dart.library.html) 'pickImgWeb.dart';
import 'SearchBoard.dart';
import 'BoardContent.dart';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ErrorPage.dart';


class salesBoard extends StatefulWidget {
  const salesBoard({super.key});

  @override
  State<salesBoard> createState() => _salesBoardState();
}

class _salesBoardState extends State<salesBoard> {

  void ChangePageWithoutDuration(Widget _page) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => _page,
      transitionDuration: Duration(seconds: 0),
    ));
  }

  @override
  Widget build(BuildContext context)
  {
    double height100 = MediaQuery.of(context).size.height/100;
    double width100 = MediaQuery.of(context).size.width/100;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Board').orderBy('timeStamp', descending: true).snapshots(),
        builder: (context, chatSnapShot) {
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            body: Column(
              children: [
                SafeArea(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: Color.fromARGB(150, 105, 204, 249), width: 3.0,),
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: IconButton(
                                      icon: Image.asset('assets/images/ujLogo.jpg',
                                        color: Colors.blue.withOpacity(1.0),
                                        colorBlendMode: BlendMode.color,),
                                      onPressed: (){
                                        Fluttertoast.showToast(msg: '아무것도 없지롱');
                                      },
                                    )
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          width: width100 * 70,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade700,
                                width: 3.0,
                              )
                          ),
                          child: TextField(
                            onChanged: (value) {

                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20
                                  ),
                                  child: Icon(Icons.search,
                                      color: Colors.grey.shade500),
                                ),
                                hintText: '눌러서 검색하기',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                )
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                          //padding: EdgeInsets.fromLTRB(50, 50.0, 50, 50),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey.shade200, width: 3.0,),
                              right: BorderSide(color: Colors.grey.shade200, width: 3.0,),
                              top: BorderSide(color: Colors.grey.shade200, width: 3.0,),
                              bottom: BorderSide(color: Colors.grey.shade200, width: 3.0,),
                            ),
                            borderRadius: BorderRadius.circular(10.0),

                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                ),

                Expanded(
                  child: Stack(
                    children: [
                      Container(
                          child: (chatSnapShot.connectionState == ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator(),)
                          : ListView.builder(
                                      reverse: true,
                                      itemBuilder: (context, index) {
                                        String postId = chatSnapShot.data!.docs[index]['postId'];
                                        int idx = chatSnapShot.data!.docs[index]['MainImage'];
                                        String MainImgPath = '';
                                        return FutureBuilder(
                                        future: getImagePath(postId, idx),
                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                          if(snapshot.hasData) {
                                            MainImgPath = snapshot.data;
                                          } else {
                                            MainImgPath = 'https://www.fluttericon.com/logo_dart_192px.svg';
                                          }


                                          return SizedBox(
                                            height: 200,
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                                                        content: SizedBox(
                                                          height: height100 * 80,
                                                          width: width100 * 80,
                                                          child: Boardcontent(
                                                            title: chatSnapShot.data!.docs[index]['title'],
                                                            content: chatSnapShot.data!.docs[index]['content'],
                                                            postId: chatSnapShot.data!.docs[index]['postId'],
                                                            imgCnt: chatSnapShot.data!.docs[index]['ImageCnt'],
                                                            publicKey: chatSnapShot.data!.docs[index]['uid'],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },

                                              child: Card(
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      child: Container(
                                                        child: Image.network(MainImgPath,
                                                          width: 150,
                                                          height: 150,
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
                                                              child: Text(chatSnapShot.data!.docs[index]['title'],
                                                              style: TextStyle(
                                                                fontSize: 25,
                                                              )),
                                                            ),

                                                            ((chatSnapShot.data!.docs[index]['content']).toString().length >= 30)
                                                                ?
                                                            Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text((chatSnapShot.data!.docs[index]['content']).toString().substring(0, 30),
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                    )
                                                                )
                                                            )
                                                                :
                                                            Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text((chatSnapShot.data!.docs[index]['content']).toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 20,
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
                                            ),
                                          );
                                        });
                                      },
                                      itemCount: chatSnapShot.data!.docs.length,
                              ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: MaterialButton(
                          onPressed: () {
                            if(FirebaseAuth.instance.currentUser == null) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return DialogErrorMsg(e: '로그인이 필요한 서비스입니다',);
                                  });
                            } else {
                              ChangePageWithoutDuration(CreateBoard());
                            }
                            },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(30),
                          shape: CircleBorder(),
                        )
                        ),
                    ],
                  ),
                ),
              ],
            )
          );
        }
    );
  }

  Future<String> getImagePath(String postId, int idx) async {
    String path = await FirebaseStorage.instance.ref('/BoardImages/' + postId + '/' + idx.toString()).getDownloadURL();
    return Future.delayed(const Duration(seconds: 1), () => path);
  }

  /*
  *
  * 카테고리 :
  *
  * 잡담
  * 익명
  * 거래
  *
  * 태그
  * 1학년
  * 2학년
  * 3학년
  * 잡담
  * 거래
  *
  *
  *
  * */



}

/*
 Container(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () { Navigator.push( context, MaterialPageRoute( builder: (context) => CreateBoard() ) ); },
                    child: Icon(Icons.add),
                  ),
                ),
              ),
* */


  /*

  */

// speeddialchild 참고하기