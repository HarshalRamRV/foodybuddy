import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;
  final controller;
  final inputType;
  UserTextField(
      {@required this.titleLabel,
      @required this.maxLength,
      @required this.icon,
      @required this.controller,
      @required this.inputType});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        style: TextStyle(fontSize: 20),
        cursorColor: Colors.black,
        maxLength: maxLength,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
