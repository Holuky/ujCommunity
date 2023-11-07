import 'package:flutter/material.dart';


TextFormField returnTextFormField(String _labelText, String _eText, TextEditingController _controller) {
  return TextFormField(
      decoration: InputDecoration(
        label: Text(
          _labelText,
          // style: TextStyle(color: Colors.lightBlueAccent.shade100, fontSize: 18),
        ),
        disabledBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.lightBlueAccent.shade100,
          ),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 10,
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightBlueAccent.shade100,
              width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          gapPadding: 10,
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        // labelText: '',
      ),
      controller: _controller,
      obscureText: false,
      autofocus: true,
      validator: (val) {
        if(val!.isEmpty)
          return _eText;
        else
          return null;
      }
  );
}