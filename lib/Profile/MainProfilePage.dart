import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainProfilePage extends StatefulWidget{
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {


  @override
  Widget build(BuildContext context) {
    String name = '';
    String num = '';

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          name = snapshot.data!['name'];
          num = snapshot.data!['num'];

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://images.velog.io/images/sdb016/post/47181c7c-1156-4182-a638-e0ad0b03a3d3/test.png'),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: null,
                      )
                    ],
                  ),

                  Text('이름 : ' + name),

                  Text('학번 : ' + num),


                ],
              ),
            ),
          );
        }
    );
  }

}
