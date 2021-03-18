import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/Tabber.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

final _url = "http://192.168.1.111:66/";

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return getnotificationlist();
  }

  gettrailling(i) {
    if (notificationlist[i].authorId == userId)
      return Container(
        width: 30,
        child: TextButton(
            child: Icon(Icons.delete_forever_outlined),
            onPressed: deleteNotification(i)),
      );
    else
      return Container(
        width: 30,
      );
  }

  getnotificationlist() {
    int n = notificationlist.length;
    var list = CupertinoScrollbar(
        controller: _scrollController,
        child: ListView.builder(
            itemCount: n,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                leading: Icon(LineIcons.bullhorn),
                title: Text(notificationlist[n - i - 1].title),
                onLongPress: () async {
                  if (notificationlist[n - i - 1].authorId == userId) {
                    print('item $i deleted');
                    await deleteNotification(n - i - 1);
                  }
                },
                subtitle: Text('بواسطة: ' + notificationlist[i].author),
              );
            }));
    return list;
  }

  deleteNotification(i) async {
    final url = Uri.parse(_url + 'api/values/del');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final body = json.encode({'Id': notificationlist[i].id});
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 10), onTimeout: () {
        return;
      });
      print(response.body);
    } catch (e) {
      print(e);
      return;
    }
    notificationlist.removeAt(i);
    setState(() {});
  }
}
