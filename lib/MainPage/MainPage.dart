
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  int MainImgCnt = 0;
  
  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height/100;
    double width100 = MediaQuery.of(context).size.width/100;
    getImgCnt();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
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
                        color: Colors.grey,
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
                          color: Colors.grey.shade800),
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
                    child: FutureBuilder(
                        future: getImagePath(MainImgCnt),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return SizedBox(
                            height: 500,
                            width: 500,
                            child: PageView.builder(
                                controller: PageController(
                                  initialPage: 0,
                                ),
                                itemCount: MainImgCnt,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Image.network(
                                      snapshot.data[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                            ),
                          );
                        }
                    ),
                  ),


                ],
              )
            ),
          )
        ]
      ),
    );
  }

  Future<List<String>> getImagePath(int ImgCnt) async {
    List<String> paths = [];
    for (int idx = 0; idx < ImgCnt; ++idx) {
      paths.add(await FirebaseStorage.instance.ref(
          '/asjdkflasldkfjaslkjdf/Main/' + idx.toString()).getDownloadURL());
    }
    return Future.delayed(const Duration(seconds: 1), () => paths);
  }
  
  void getImgCnt() async {
    var res = await FirebaseFirestore.instance.collection('afsjdlsadlfkjsadflkjvncmx,zvmnasdklfnqwejkvcnsavuio').doc('ajKJDd6Tqnda4FiZInyQ').get();
    MainImgCnt = res.data()!['ImportantImgCnt'];
  }
}