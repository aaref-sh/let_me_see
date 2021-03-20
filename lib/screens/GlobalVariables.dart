import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

List<Lecture> lecturelist;
List<Notificate> notificationlist;
List<Doc> doclist;
List<Requst> requestlist;

final url0 = "http://192.168.1.111:66/";

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json'
};

int userId;
bool isateacher;
int selectedIndex = 0;

String dropdownValue = 'مصدقة تأجيل';

List<String> spinnerItems = [
  'مصدقة تأجيل',
  'تسلسل دراسي',
  'كشف علامات',
  'مصدقة تخرج',
  'توصيف مواد'
];

showMaterialDialog(i, context) {
  var msgs = [
    'تم رفع الملفات ✔',
    'فشل رفع الملفات ⚠',
    'فشل حذف الملفات',
    'لا يمكن الوصول للخادم'
  ];
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(msgs[i]),
            actions: <Widget>[
              TextButton(
                child: Text('تم'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
