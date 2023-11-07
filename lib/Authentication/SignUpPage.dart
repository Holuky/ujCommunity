import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../Designed/DesignedWidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  void ChangePageWithoutDuration(Widget _page) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => _page,
      transitionDuration: Duration(seconds: 0),
    ));
  }

  @override
  Widget build(BuildContext context) {

        return Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 800,
                  width: 570,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0) ,
                    //padding: EdgeInsets.fromLTRB(50, 50.0, 50, 50),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                        right: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                        top: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                        bottom: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                      ),
                      borderRadius: BorderRadius.circular(10.0),

                      color: Colors.white,
                    ),
            child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () { Navigator.pop(context); },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Center(
                      child: Column(
                          children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/ujLogo.jpg',
                              color: Colors.blue.withOpacity(1.0),
                              colorBlendMode: BlendMode.color,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: Text('운정고 커뮤니티에 오신 것을 환영합니다\n로그인을 하여 모든 기능을 이용하세요!',
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              )
                          ),
                        ),

                        SizedBox(
                          height: 80,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: OutlinedButton.icon(
                              icon: Icon(Icons.email_outlined),
                              label: Text("이메일로 시작하기",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              onPressed: () => setState(() {
                                ChangePageWithoutDuration(SignUpWithEmailPage());
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: OutlinedButton.icon(
                              icon: Icon(Icons.email_outlined),
                              label: Text("Gmail로 시작하기",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              onPressed: () => setState(() {

                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: OutlinedButton.icon(
                              icon: Icon(Icons.phone_android_outlined),
                              label: Text("전화번호로 시작하기",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              onPressed: () => setState(() {
                              }),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
            ),
          ),
                ),
              ),
        );
  }



  void SignUpWithGmail() async {}
}

class SignUpWithEmailPage extends StatefulWidget {
  const SignUpWithEmailPage({super.key});

  @override
  State<SignUpWithEmailPage> createState() => _SignUpWithEmailPageState();
}

class _SignUpWithEmailPageState extends State<SignUpWithEmailPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _rePwdController = TextEditingController();

  bool isStudent = true;
  bool isParent = false;
  late List<bool> _isSelected;

  @override
  Widget build(BuildContext context) {
    _isSelected = [isStudent, isParent];

    return Scaffold(
      body: Center(
        child: Form(
          key: _key,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 1200,
                width: 570,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0) ,
                  //padding: EdgeInsets.fromLTRB(50, 50.0, 50, 50),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                      right: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                      top: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                      bottom: BorderSide( color: Colors.grey.shade200, width: 3.0,),
                    ),
                    borderRadius: BorderRadius.circular(10.0),

                    color: Colors.white,
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),

                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            top: 10,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context); },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          ),

                          Center(
                            child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset(
                                        'assets/images/ujLogo.jpg',
                                        color: Colors.blue.withOpacity(1.0),
                                        colorBlendMode: BlendMode.color,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                                    child: Text(
                                      '안녕하세요!\n이 앱은 자율교육과정 프로젝트의 일환으로 개발된 앱입니다.\n운정고 여러분들의 많은 관심 부탁드립니다!',
                                      textAlign: TextAlign.center,
                                        style: TextStyle(
                                      fontSize: 18,
                                    )
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(50.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ToggleButtons(
                                          constraints: BoxConstraints(minWidth: 70, maxWidth: 170),
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(55, 10, 10, 10),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.book_outlined),
                                                  Text('학생'),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(50, 10, 10, 10),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.person),
                                                  Text('학부모'),
                                                ],
                                              ),
                                            ),
                                          ],

                                          isSelected: _isSelected,
                                          onPressed: (idx) {
                                            setState(() {
                                              if (idx == 0) {
                                                isStudent = true;
                                                isParent = false;
                                              } else {
                                                isStudent = false;
                                                isParent = true;
                                              }

                                              setState(() {
                                                _isSelected = [isStudent, isParent];
                                              });
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 학번
                                  SizedBox(
                                    height: 100.0,
                                    width: 400.0,
                                    child: returnTextFormField(
                                        '학번', '필수 항목입니다', _numberController),
                                  ),

                                  // 이름
                                  SizedBox(
                                    height: 100.0,
                                    width: 400.0,
                                    child: returnTextFormField('이름', '필수 항목입니다', _nameController),
                                  ),

                                  // 이메일
                                  SizedBox(
                                    height: 100.0,
                                    width: 400.0,
                                    child: returnTextFormField(
                                        '이메일', '필수 항목입니다', _emailController),
                                  ),

                                  // 비밀번호
                                  SizedBox(
                                    height: 100.0,
                                    width: 400.0,
                                    child: returnTextFormField(
                                        '비밀번호', '필수 항목입니다', _pwdController),
                                  ),

                                  // 비밀번호 확인
                                  SizedBox(
                                    height: 100.0,
                                    width: 400.0,
                                    child: returnTextFormField(
                                        '비밀번호 재입력', '필수 항목입니다', _rePwdController),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                                    child: SizedBox(
                                        width: 400.0,
                                        height: 50.0,
                                        child: ElevatedButton(
                                            onPressed: SignUpWithEmail,
                                            child: Text("계정 만들기!"))),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignUpWithEmail() async {
    bool isErrored = false;
    String uidTmp = '';
    if (_key.currentState!.validate()) {
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _pwdController.text,
        );
        uidTmp = credential.user!.uid.toString();
      } on FirebaseAuthException catch (e) {
        isErrored = true;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      }

      if (isErrored == false) {
        int role = 0;
        if (isParent == true)
          role = 1;
        else if (isStudent == true) role = 0;

        String now = DateFormat('yy.MM.dd').format(DateTime.now());
        FirebaseFirestore.instance.collection('Users').doc(uidTmp).set({
          'email': _emailController.text,
          'name': _nameController.text,
          'num': _numberController.text,
          'role': role,
          'timeStamp': now.toString()
        });
      }
    }
  }
}
