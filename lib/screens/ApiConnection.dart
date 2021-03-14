import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/LoadingPage.dart';
import 'package:let_me_see/screens/Tabber.dart';

class ApiConnection extends StatefulWidget {
  final int userId; // receives the value
  ApiConnection({Key key, this.userId}) : super(key: key);

  @override
  _ApiConnectionState createState() => _ApiConnectionState();
}

class _ApiConnectionState extends State<ApiConnection> {
  int studentId;

  @override
  void initState() {
    super.initState();
    studentId = widget.userId;
    getServerData();
  }

  @override
  Widget build(BuildContext context) {
    if (lecturelist == null) return LoadingPage('يجري الاتصال بالخادم');
    if (unavilable)
      return Scaffold(
          body: Center(
              child: Text(
        "لا يمكن الوصول للخادم :( ",
        style: TextStyle(color: Colors.grey[600], fontSize: 30),
        textDirection: TextDirection.rtl,
      )));
    return Tabber();
  }

  bool unavilable = false;
  getServerData() async {
    var url = 'http://192.168.1.111:66/api/values/daystable/$studentId';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 10), onTimeout: () {
        return;
      });
      lecturelist = <Lecture>[];
      var jsonData = json.decode(response.body);
      for (var i in jsonData) {
        Lecture l = Lecture.fromMap(i);
        lecturelist.add(l);
      }
      url = 'http://192.168.1.111:66/api/values/notificationlist';
      response = await http.get(Uri.parse(url), headers: headers);
      jsonData = json.decode(response.body);
      for (var i in jsonData) {
        Notificate x = Notificate.fromMap(i);
        notificationlist.add(x);
      }
      setState(() {});
    } catch (e) {
      lecturelist = <Lecture>[];
      unavilable = true;
      setState(() {});
    }
  }
}
