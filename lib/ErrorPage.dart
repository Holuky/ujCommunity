
import 'package:flutter/material.dart';

class DialogErrorMsg extends StatefulWidget {
  DialogErrorMsg({required this.e});

  late String e;

  @override
  State<DialogErrorMsg> createState() => _DialogErrorMsgState();
}

class _DialogErrorMsgState extends State<DialogErrorMsg> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
      content: SizedBox(
        //height: MediaQuery.of(context).size.height * 0.8,
        //width: MediaQuery.of(context).size.width * 80,
        child: Container(
          child: Text(widget.e),
        ),
      ),
    );
  }
}