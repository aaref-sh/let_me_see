import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(LineIcons.bullhorn),
          onTap: () => print('go hack yourself'),
          title: Text("إلغاء محاضرة السبت"),
          subtitle: Text('بواسطة: الدكتور عامر'),
        ),
        ListTile(
          leading: Icon(LineIcons.bullhorn),
          onTap: () => print('go hack yourself'),
          title: Text("إلغاء محاضرة السبت"),
          subtitle: Text('بواسطة: الدكتور عامر'),
        ),
        ListTile(
          leading: Icon(LineIcons.bullhorn),
          onTap: () => print('go hack yourself'),
          title: Text("إلغاء محاضرة السبت"),
          subtitle: Text('بواسطة: الدكتور عامر'),
        ),
        ListTile(
          leading: Icon(LineIcons.bullhorn),
          onTap: () => print('go hack yourself'),
          title: Text("إلغاء محاضرة السبت"),
          subtitle: Text('بواسطة: الدكتور عامر'),
        ),
        ListTile(
          leading: Icon(LineIcons.bullhorn),
          onTap: () => print('go hack yourself'),
          title: Text("إلغاء محاضرة السبت"),
          subtitle: Text('بواسطة: الدكتور عامر'),
        ),
      ],
    );
  }
}
