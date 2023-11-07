
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
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';

import 'pickImgMobile.dart'
  if (dart.library.html) 'pickImgWeb.dart';

class CreateBoard extends StatefulWidget {
  const CreateBoard({super.key});

  @override
  State<CreateBoard> createState() => _CreateBoardState();
}

class _CreateBoardState extends State<CreateBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}