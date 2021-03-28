import 'dart:math';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:let_me_see/screens/TableScreen.dart';

import 'GlobalVariables.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var u = 's';
    if (isateacher) u = 't';
    return ListView(
      children: [
        SizedBox(
            height: (MediaQuery.of(context).size.width) * 0.57,
            width: MediaQuery.of(context).size.width,
            child: Carousel(
              images: [
                for (int i = 1; i <= 5; i++) Image.asset('images/$u$i.jpg'),
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.purple.withOpacity(0.5),
              borderRadius: true,
            )),
        if (!isateacher)
          Carde(
            text: Text(
              'الجدول',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            widget: TableScreen(),
            height: 250.0,
          ),
        Carde(
          text: Text(
            'الإعلانات',
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
          widget: Notifications(),
          height: min(350.0, notificationlist.length * 75.0),
        ),
      ],
    );
  }
}

class Carde extends StatelessWidget {
  final text;
  final widget;
  final height;
  @override
  Carde({this.text, this.widget, this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 7, right: 7),
      child: Container(
        //height: 600,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
            // Make rounded corners
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey[700],
                ),
              )),
              child: Center(
                  child:
                      Padding(padding: EdgeInsets.only(top: 10), child: text)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18)),
                  child: Container(
                    height: height,
                    child: widget,
                    color: Color.fromARGB(245, 255, 255, 255),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
