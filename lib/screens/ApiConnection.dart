import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/GlobalVariables.dart';
import 'package:let_me_see/screens/LoadingPage.dart';
import 'package:let_me_see/screens/Tabber.dart';

class ApiConnection extends StatefulWidget {
  final int userId; // receives the value
  final bool isateacher;
  ApiConnection({Key key, this.userId, this.isateacher}) : super(key: key);

  @override
  _ApiConnectionState createState() => _ApiConnectionState();
}

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
    var url = url0 + 'api/values/daystable/$userId';

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
      await updatenotificationlist();
      if (isateacher) lecturelist = <Lecture>[];
      await updatedoclist();
    } catch (e) {
      unavilable = true;
    }
    setState(() {});
  }
}

updatedoclist() async {
  doclist = <Doc>[];
  var url =
      url0 + 'api/values/GetDocList/' + (isateacher ? userId.toString() : "");
  var response = await http
      .get(Uri.parse(url), headers: headers)
      .timeout(Duration(seconds: 10), onTimeout: () {
    return;
  });
  var jsonData = json.decode(response.body);
  for (var i in jsonData) {
    Doc d = Doc.fromMap(i);
    doclist.add(d);
    print(i['path'].split('\\').last);
  }
}

updatenotificationlist() async {
  notificationlist = <Notificate>[];
  var url = url0 + 'api/values/notificationlist';
  var response = await http
      .get(Uri.parse(url), headers: headers)
      .timeout(Duration(seconds: 10), onTimeout: () {
    return;
  });
  var jsonData = json.decode(response.body);
  for (var i in jsonData) {
    Notificate x = Notificate.fromMap(i);
    notificationlist.add(x);
  }
}

updaterequestlist() async {
  if (!isateacher) {
    requestlist = <Requst>[];
    var body = json.encode({'Id': userId.toString()});
    var url = url0 + 'api/values/requestlist';
    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    var jsonData = json.decode(response.body);
    for (var i in jsonData) {
      var x = Requst.fromMap(i);
      requestlist.add(x);
    }
  }
}
