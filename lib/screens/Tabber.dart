import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:let_me_see/screens/TableScreen.dart';
import 'package:line_icons/line_icons.dart';

List<Lecture> lecturelist;
List<Notificate> notificationlist = <Notificate>[];

class Tabber extends StatefulWidget {
  @override
  _TabberState createState() => _TabberState();
}

class _TabberState extends State<Tabber> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TableScreen(),
    Notifications(),
    Text(
      'Likes',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'الرئيسية',
                  ),
                  GButton(
                    icon: LineIcons.table,
                    text: 'الجدول',
                  ),
                  GButton(
                    icon: LineIcons.bullhorn,
                    text: 'الإعلانانات',
                  ),
                  GButton(
                    icon: LineIcons.fileInvoice,
                    text: 'الطلبات',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
