import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/Tabber.dart';
import 'package:line_icons/line_icons.dart';

class Notifications extends StatelessWidget {
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
            // reverse: true,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                leading: Icon(LineIcons.bullhorn),
                title: Text(notificationlist[n - i - 1].title),
                subtitle: Text('بواسطة: ' + notificationlist[i].author),
                onTap: () {},
              );
            }));
    return list;
  }
}
