import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/Tabber.dart';
import 'package:line_icons/line_icons.dart';

class Notifications extends StatelessWidget {
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
                onLongPress: () {
                  if (notificationlist[n - i - 1].authorId == userId)
                    print('delete $i item');
                },
                // trailing: gettrailling(n - i - 1),
                subtitle: Text('بواسطة: ' + notificationlist[i].author),
              );
            }));
    return list;
  }

  deleteNotification(i) {}
}
