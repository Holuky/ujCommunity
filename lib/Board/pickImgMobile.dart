
// import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:timer_builder/timer_builder.dart';
// import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

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


  // 이미지 관련 설정
  final maxImageCnt = 4;
  late String _postId;

  final picker = ImagePicker();
  List<XFile>? pickedImgs;
  List<bool> isImageAvailable = [false, false, false, false];

  Future<void> pickImgs() async {
    List<XFile>? pickedImgstmp = await picker.pickMultiImage();
    List<bool> tmp = [false, false, false, false];
    if (pickedImgstmp != null) {
      for (int idx = 0; idx < maxImageCnt; ++idx) {
        if (idx < pickedImgstmp!.length)
          tmp[idx] = true;
        else
          tmp[idx] = false;
      }
      isImageAvailable = tmp;
      setState(() {
        pickedImgs = pickedImgstmp;
      });
    } else {
      Fluttertoast.showToast(msg: '이미지가 선택되지 않았습니다');
    }
  }
  @override
  Widget build(BuildContext context) {

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

    _postId = getRandomPassword();

    return Scaffold(
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

      body: Column(
        children: [
          // 타이틀 제작
          TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(


                  ),
                ),
                hintText: '제목',
                // labelText: '',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              controller: _titleController,
              obscureText: false,
              autofocus: true,
              validator: (val) {
                if(val!.isEmpty)
                  return '필수 항목입니다!';
                else
                  return null;
              }
          ),

          // 내용 작성
          TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '내용',
                // labelText: '',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              controller: _contentController,
              obscureText: false,
              autofocus: true,
              validator: (val) {
                if(val!.isEmpty)
                  return '필수 항목입니다!';
                else
                  return null;
              }
          ),

          SizedBox(
            // height이 없으면 오류가 남,,, ....
            height: 400,
            child: GridView.count(
              crossAxisCount: maxImageCnt,
              // mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                maxImageCnt,
                    (index) => DottedBorder(
                  color: Colors.grey,
                  dashPattern: [5, 5],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (isImageAvailable[index] == true) ?
                        Image.file(File(pickedImgs![index].path)).image :
                        Image.network('https://goo.su/logos/logo_blue_white.png').image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _containerList[index],
                  ),
                ),
              ).toList(),
            ),
          ),

          // 참고 : https://velog.io/@dosilv/Flutter-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%97%85%EB%A1%9C%EB%8D%94-%EB%A7%8C%EB%93%A4%EA%B8%B0

          ElevatedButton(
              onPressed: () {
                // String now = DateFormat('yy.MM.dd').format(DateTime.now());

                if(pickedImgs != null) {
                  for (int idx = 0; idx < pickedImgs!.length; ++idx) {
                    FirebaseStorage.instance.ref(
                        '/FreeBoardImages/test').putFile(
                      File(pickedImgs![idx].path), SettableMetadata(
                      contentType: "image/png",
                    ),);
                  }
                }
                // String now = DateFormat('yy.MM.dd').format(DateTime.now());
                FirebaseFirestore.instance.collection('FreeBoard').add({
                  'title': _titleController.text,
                  'content': _contentController.text,
                  'uid': FirebaseAuth.instance.currentUser!.uid,
                  'timeStamp': Timestamp.now()
                });
                //Navigator.pop(context);
              },
              child: Text("게시!"))

        ],
      ),
    );

  }

  /*
  void getData() async {

    final ref = FirebaseStorage.instance.ref().child('FreeBoardImages');
    var url = await ref.getDownloadURL();

    setState(() async {
      _imageData = await FirebaseStorage.instance.ref().child('FreeBoardImages').getData();
    });
  }


  Future<void> pickImg() async {
    // var permissionStatus = Permission.photos.request();
    if (kIsWeb) {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {

        if (images.length >= maxImageCnt) {
          Fluttertoast.showToast(msg: '이미지는 최대 4개까지 업로드 가능합니다');
        }

        // setState(() {
        //   _pickedImgs = images;
        // });

        for (int idx = 0; idx < images.length; ++idx) {
          String path = images[idx].path;
          Uint8List imageData = await XFile(path).readAsBytes();

          FirebaseStorage.instance.
          ref('/FreeBoardImages').
          putData(imageData);
        }


      } else {
        Fluttertoast.showToast(msg: '이미지를 선택해 주세요');
      }
    }
  }
*/

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

  String getRandomPassword() {
    var _random = Random();
    //무조건 들어갈 문자종류(문자,숫자,특수기호)의 위치를 기억할 리스트
    var leastCharacterIndex = [];
    var min = 0x21; //start ascii  사용할 아스키 문자의 시작
    var max = 0x7A; //end ascii    사용할 아스키 문자의 끝
    var dat = [];   //비밀번호 저장용 리스트
    while(dat.length <= 20) { //무작위로 20개를 생성한다
      var tmp = min + _random.nextInt(max - min); //랜덤으로 아스키값 받기

      dat.add(tmp); //dat 리스트에 추가
    }

    return String.fromCharCodes(dat.cast<int>());
  }

}