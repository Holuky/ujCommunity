
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Profile/MainProfilePage.dart';
import 'SignUpPage.dart';

import '../Designed/DesignedWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  bool isLogined = false;
  double mWidth = 0;

  void ChangePageWithoutDuration(Widget _page) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => _page,
      transitionDuration: Duration(seconds: 0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    mWidth = MediaQuery.of(context).size.width;
    _emailController.value = TextEditingValue(text: 'wans4908@gmail.com');
    _pwdController.value = TextEditingValue(text: 'wan49082756');
    if(isLogined == false) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 700,
            width: 570,
            child: Container(
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
              child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: '아무 기능도 없는데요?',
                          );
                        },
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
                              child: Text(
                                  '운정고 커뮤니티에 오신 것을 환영합니다\n로그인을 하여 모든 기능을 이용하세요!',
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
                                  label: Text("이메일로 로그인하기",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  onPressed: () {
                                    ChangePageWithoutDuration(EmailLoginPage());
                                  },
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
                                  label: Text("구글로 로그인하기",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    // ChangePageWithoutDuration(GmailLoginPage());
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                              child: TextButton(
                                  child: Text("아직 계정이 없으신가요?"),
                                  onPressed: () {
                                    ChangePageWithoutDuration(SignUpPage());
                                  }
                              ),
                            ),
                          ]
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ),
      );
    } else {
      return MainProfilePage();
    }
  }

  Scaffold EmailLoginPage() {
    return Scaffold(
      body: Center(
        child: Form(
          key: _key,
          child:
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 570,
              height: 700,
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
                    children:[

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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                              child: Text('운정고 커뮤니티에 오신 것을 환영합니다\n로그인을 하여 모든 기능을 이용하세요!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                )
                              ),
                            ),

                            SizedBox(
                              height: 100.0,
                              width: 400.0,
                              child: returnTextFormField('이메일', '오류!', _emailController),
                            ),

                            SizedBox(
                              height: 100.0,
                              width: 400.0,
                              child : returnTextFormField('비밀번호', '오류!', _pwdController),
                            ),

                            SizedBox(
                                height: 50.0,
                                width: 400.0,
                                child: LoginWithEmail(),
                            ),
                          ]
                    ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
          ),
        ),
      );
  }

  ElevatedButton LoginWithEmail() {

    return ElevatedButton(
        onPressed: () async {
          bool isErrored = false;
          if(_key.currentState!.validate()) {
            try{
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text,
                  password: _pwdController.text);
            } on FirebaseAuthException catch(e)
            {
              isErrored = true;
              if(e.code == 'user-not-found') {
                debugPrint('No such profile found!');
              } else if(e.code == 'wrong-password') {
                debugPrint('Wrong Password!');
              }
            }
          }
          if(isErrored == false) {
            if(!mounted)
              return;
            isLogined = true;
            setState(() {
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text("로그인!", style: TextStyle(fontSize: 18,)),
        )
    );
  }
}