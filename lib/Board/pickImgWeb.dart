
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:timer_builder/timer_builder.dart';
// import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

import '../UsefulFunctions/UsefulFunctions.dart';

class CreateBoard extends StatefulWidget {
  const CreateBoard({super.key});

  @override
  State<CreateBoard> createState() => _CreateBoardState();
}

class _CreateBoardState extends State<CreateBoard> {


  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();


  List<String> list = ['Java', 'Flutter', 'Kotlin', 'Swift', 'Objective-C'],
      selected = [];
  late TextEditingController tc;

  // 이미지 관련 설정
  final maxImageCnt = 2;
  int selectedImgCnt = 0;
  late String _postId;

  List<Uint8List>? pickedImgsWeb;
  List<bool> isImageAvailable = [false, false, false, false];
  Future<void> pickImgs() async {
    List<Uint8List>? pickedImgsWebtmp = await ImagePickerWeb.getMultiImagesAsBytes();
    List<bool> tmp = [false, false, false, false];
    if (pickedImgsWebtmp != null) {
      for (int idx = 0; idx < maxImageCnt; ++idx) {
        if (idx < pickedImgsWebtmp!.length)
          tmp[idx] = true;
        else
          tmp[idx] = false;
      }
      isImageAvailable = tmp;
      setState(() {
        pickedImgsWeb = pickedImgsWebtmp;
        selectedImgCnt = pickedImgsWebtmp.length;
      });
    } else {
      Fluttertoast.showToast(msg: '이미지가 선택되지 않았습니다');
    }
  }

  int SelectedMainImage = 0;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height/100;
    double width100 = MediaQuery.of(context).size.width/100;

    // 클래스의 함수 실행은 특정 클래스의 함수 안에서만 가능
    List<Widget> _containerList = [
      Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          onPressed: pickImgs,
        ),
      ),
      Container(),
      Container(),
      Container(),
    ];

    // 게시물 Id 설정
    _postId = getRandomPassword(20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("게시판"),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); },
          icon: Icon(Icons.arrow_back_ios),
        ),

      ),

      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context)
        .copyWith(scrollbars: false),

      child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0) ,
                  child: const Center(
                    child: Text('새 게시물 작성',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                        ),
                    ),
                  ),
                ),

                // 본문 제작
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight:Radius.circular(10),
                      topLeft:Radius.circular(10),
                      bottomRight:Radius.circular(10),
                      bottomLeft:Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  width: width100 * 80,
                  height: 1000,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 0,),
                              right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                              top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 0,),
                              bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 0,),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft:Radius.circular(10),
                              bottomLeft:Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          width: width100 * 10,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('게시물',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),),
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: '당신의 개성 넘치는 게시물의 제목은?!',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey
                                            )
                                        )
                                    ),
                                        controller: _titleController,
                                        obscureText: false,
                                        autofocus: true,
                                        expands: true,
                                        minLines: null,
                                        maxLines: null,
                                        validator: (val) {
                                          if(val!.isEmpty)
                                            return '제목은 필수!';
                                          else
                                            return null;
                                          },
                                        style: const TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'NotoSansKR',
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                              ),

                              Expanded(
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: '당신의 개성 넘치는 게시물의 내용은?!',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none
                                        )
                                    ),

                                    controller: _contentController,
                                    obscureText: false,
                                    autofocus: true,
                                    expands: true,
                                    minLines: null,
                                    maxLines: null,

                                    validator: (val) {
                                      if(val!.isEmpty)

                                        return '제목은 필수!';
                                      else
                                        return null;
                                    },
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w600,
                                    )
                                ),
                              ),


                            ],
                          ),
                        ),
                      ],
                  ),
                ),

                // 이미지 선택
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0) ,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                    ),
                    borderRadius: BorderRadius.only(
                        topRight:Radius.circular(10),
                        topLeft:Radius.circular(10)
                    ),
                    color: Colors.white,
                  ),
                  width: width100 * 80,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('이미지',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                      Text('[4/${selectedImgCnt}]',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),


                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(10),
                        bottomLeft:Radius.circular(10)
                    ),

                    color: Colors.white,
                  ),
                  width: width100 * 80,
                  height: width100 * 80,
                    // height이 없으면 오류가 남,,, ....
                    child: GridView.count(
                      crossAxisCount: maxImageCnt,
                      // mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        4,
                            (index) => DottedBorder(
                          color: Colors.grey,
                          dashPattern: [5, 5],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                SelectedMainImage = index;
                              });
                            },
                            child: Container(
                              decoration: (isImageAvailable[index] == true) ? ( BoxDecoration(
                                border: (SelectedMainImage == index) ? Border.all( color: Colors.blueAccent.shade100, width: 5.0 ) : null,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),

                                image: DecorationImage(
                                    image:
                                    Image.memory(pickedImgsWeb![index]).image,
                                  fit: BoxFit.cover,
                                ))) :
                                (null),
                              child: _containerList[index],
                            ),
                          ),
                        ),
                      ).toList(),
                  ),
                ),

                // 태그 선택
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0) ,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                    ),
                    borderRadius: BorderRadius.only(
                        topRight:Radius.circular(10),
                        topLeft:Radius.circular(10)
                    ),
                    color: Colors.white,
                  ),
                  width: width100 * 80,
                  height: 50,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('태그',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('몇 개 했을까요? 두둥탁',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      right: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      top: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                      bottom: BorderSide( color: Colors.lightBlueAccent.shade100, width: 3.0,),
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft:Radius.circular(10),
                        bottomRight:Radius.circular(10)
                    ),
                    color: Colors.white,
                  ),
                  width: width100 * 80,
                  child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: selected.map((s) {
                        return Chip(
                            backgroundColor: Colors.blue[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            label: Text(s,
                                style:
                                TextStyle(color: Colors.blue[900])),
                            onDeleted: () {
                              setState(() {
                                selected.remove(s);
                              });
                            });
                      }).toList()
                  ),
                ),

                // 참고 : https://velog.io/@dosilv/Flutter-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%97%85%EB%A1%9C%EB%8D%94-%EB%A7%8C%EB%93%A4%EA%B8%B0

                Container(
                  margin: EdgeInsets.fromLTRB(0, 70, 0, 100),
                  child: SizedBox(
                    width: width100 * 80,
                    child: ElevatedButton(
                        onPressed: () {
                          if(pickedImgsWeb != null) {
                            for (int idx = 0; idx < pickedImgsWeb!.length; ++idx) {
                              String directory = '/BoardImages/' + _postId.toString() + '/' + idx.toString();
                              FirebaseStorage.instance.ref(
                                  directory).putData(
                                pickedImgsWeb![idx], SettableMetadata(
                                contentType: "image/png",
                              ),
                              );
                            }
                          }
                          // String now = DateFormat('yy.MM.dd').format(DateTime.now());
                          FirebaseFirestore.instance.collection('Board').doc(_postId).set({
                            'title': _titleController.text,
                            'content': _contentController.text,
                            'postId': _postId.toString(),
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'MainImage' : SelectedMainImage,
                            'ImageCnt' : selectedImgCnt,
                            'timeStamp': Timestamp.now()
                          });
                          //Navigator.pop(context);

                        },
                        child: Text("게시글 작성 완료!")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget returnAlertWindow(String e) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
      content: Container(
        height: 400.0,
        width: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(e),
            OutlinedButton(
              onPressed: null,
              child: null,
            )
          ],
        ),
      ),
    );
  }

}
