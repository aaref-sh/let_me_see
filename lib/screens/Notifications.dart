import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

import 'GlobalVariables.dart';

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
                    await deleteConfirmationDialog(n - i - 1);
                  }
                },
                subtitle: Text('بواسطة: ' + notificationlist[n - 1 - i].author),
              );
            }));
    return list;
  }

  deleteNotification(i) async {
    final url = Uri.parse(url0 + 'api/values/del');
    final body = json.encode({'Id': notificationlist[i].id});
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 10), onTimeout: () {
        return;
      });
      print('item $i deleted');
      print(response.body);
    } catch (e) {
      print(e);
      return;
    }
    notificationlist.removeAt(i);
    setState(() {});
  }

  deleteConfirmationDialog(id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('هل تريد بالتأكيد حذف الإعلان؟'),
          content: Text('لا يمكنك التراجع بعد الحذف'),
          actions: <Widget>[
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                deleteNotification(id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
