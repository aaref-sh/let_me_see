import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/Tabber.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {
  runApp(MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child);
      },
      title: 'my referance',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
      ),
      home: ConnectintApi()));
}

class ConnectintApi extends StatefulWidget {
  const ConnectintApi({
    Key key,
  }) : super(key: key);

  @override
  _ConnectintApiState createState() => _ConnectintApiState();
}

class _ConnectintApiState extends State<ConnectintApi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServerData();
  }

  @override
  Widget build(BuildContext context) {
    if (lecturelist == null)
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    'يجري الاتصال بالخادم...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 30),
                    textDirection: TextDirection.rtl,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            ),
          ],
        ),
      );
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
    var url = 'http://192.168.1.111:66/api/values/daystable/1233';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 10), onTimeout: () {
        // lecturelist = <Lecture>[];
        // unavilable = true;
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
      unavilable = true;
      setState(() {});
    }
  }
}
