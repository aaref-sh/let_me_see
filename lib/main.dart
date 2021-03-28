import 'package:flutter/material.dart';
import 'package:let_me_see/screens/Login.dart';

void main() async {
  runApp(MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child);
      },
      title: 'Student Services',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      home: LoginPage()));
}
