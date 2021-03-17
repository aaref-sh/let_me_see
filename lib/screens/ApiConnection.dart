import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/LoadingPage.dart';
import 'package:let_me_see/screens/Tabber.dart';

class ApiConnection extends StatefulWidget {
  final int userId; // receives the value
  final bool isateacher;
  ApiConnection({Key key, this.userId, this.isateacher}) : super(key: key);

  @override
  _ApiConnectionState createState() => _ApiConnectionState();
}

int userId;
bool isateacher;

class _ApiConnectionState extends State<ApiConnection> {
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    isateacher = widget.isateacher;
    getServerData();
  }

  @override
  Widget build(BuildContext context) {
    if (unavilable)
      return Scaffold(
          body: Center(
              child: Text(
        "لا يمكن الوصول للخادم :( ",
        style: TextStyle(color: Colors.grey[600], fontSize: 30),
        textDirection: TextDirection.rtl,
      )));
    if (lecturelist == null) return LoadingPage('يجري الاتصال بالخادم');
    return Tabber();
  }

  bool unavilable = false;
  getServerData() async {
    var url = 'http://192.168.1.111:66/api/values/daystable/$userId';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    http.Response response;
    var jsonData;
    try {
      if (!isateacher) {
        response = await http
            .get(Uri.parse(url), headers: headers)
            .timeout(Duration(seconds: 10), onTimeout: () {
          return;
        });
        jsonData = json.decode(response.body);
        lecturelist = <Lecture>[];
        for (var i in jsonData) {
          Lecture l = Lecture.fromMap(i);
          lecturelist.add(l);
        }
      }
      url = 'http://192.168.1.111:66/api/values/notificationlist';
      response = await http.get(Uri.parse(url), headers: headers);
      jsonData = json.decode(response.body);
      for (var i in jsonData) {
        Notificate x = Notificate.fromMap(i);
        notificationlist.add(x);
      }
      if (isateacher) lecturelist = <Lecture>[];
    } catch (e) {
      unavilable = true;
    }
    setState(() {});
  }
}
