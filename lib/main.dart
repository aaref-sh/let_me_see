import 'package:flutter/material.dart';
import 'package:let_me_see/screens/Tabber.dart';

void main() => runApp(MyApp());
BuildContext cntxt;

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cntxt = context;
    return MaterialApp(
        builder: (context, child) {
          return Directionality(textDirection: TextDirection.rtl, child: child);
        },
        title: 'my referance',
        theme: ThemeData(
          primaryColor: Colors.grey[800],
        ),
        home: Tabber());
  }
}
