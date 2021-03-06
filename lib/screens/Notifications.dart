import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

import 'GlobalVariables.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    'قائمة الإعلانات',
                    style: TextStyle(color: Colors.grey[600], fontSize: 28),
                  )),
                ))),
        Container(
          height: MediaQuery.of(context).size.height - 150,
          child: Notifications(),
        )
      ],
    ));
  }
}

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
            itemBuilder: (BuildContext context, int index) {
              int i = n - 1 - index;
              return ListTile(
                leading: Icon(LineIcons.bullhorn),
                title: Text(notificationlist[i].title),
                onTap: () {
                  print('notificatin tapped');
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(notificationlist[i].title),
                            content: Text(notificationlist[i].description),
                            actions: <Widget>[
                              TextButton(
                                child: Text('تم'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                },
                onLongPress: () async {
                  if (notificationlist[i].authorId == userId) {
                    await deleteConfirmationDialog(i);
                  }
                },
                subtitle: Text('بواسطة: ' + notificationlist[i].author),
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
