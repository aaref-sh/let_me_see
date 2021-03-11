import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
        title: "GNav",
        theme: ThemeData(
          primaryColor: Colors.grey[800],
        ),
        home: Example());
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    homeScreen(),
    tableScreen(),
    notifications(),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
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
                    icon: LineIcons.user,
                    text: 'Profile',
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

notifications() {
  return ListView(
    children: [
      ListTile(
        leading: Icon(LineIcons.bullhorn),
        title: Text("إلغاء محاضرة السبت"),
        subtitle: Text('بواسطة: الدكتور عامر'),
      )
    ],
  );
}

TextStyle ts = TextStyle(color: Colors.white);
tableScreen() {
  return Container(
    child: GridView.count(
      crossAxisCount: 6,
      children: [
        Container(
            color: Colors.green[700],
            child: Center(child: Text('الوقت', style: ts))),
        Container(
            color: Colors.green,
            child: Center(child: Text('الأحد', style: ts))),
        Container(
            color: Colors.green,
            child: Center(child: Text('الاثنين', style: ts))),
        Container(
            color: Colors.green,
            child: Center(child: Text('الثلاثاء', style: ts))),
        Container(
            color: Colors.green,
            child: Center(child: Text('الأربعاء', style: ts))),
        Container(
            color: Colors.green,
            child: Center(child: Text('الخميس', style: ts))),
        Container(
            color: Colors.green[700],
            child: Center(child: Text('8:00', style: ts))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح1'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح2'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح3'))),
        Container(color: Colors.grey[300], child: Center(child: Text('non'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح5'))),
        Container(
            color: Colors.green[700],
            child: Center(child: Text('10:00', style: ts))),
        Center(child: Text('مح1')),
        Center(child: Text('مح2')),
        Center(child: Text('non')),
        Center(child: Text('مح3')),
        Center(child: Text('مح5')),
        Container(
            color: Colors.green[700],
            child: Center(child: Text('12:00', style: ts))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح1'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح2'))),
        Container(color: Colors.grey[300], child: Center(child: Text('non'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح3'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح5'))),
        Container(
            color: Colors.green[700],
            child: Center(child: Text('10:00', style: ts))),
        Center(child: Text('non')),
        Center(child: Text('مح1')),
        Center(child: Text('مح2')),
        Center(child: Text('مح3')),
        Center(child: Text('مح5')),
      ],
    ),
  );
}

homeScreen() {
  return ListView(
    children: [
      Container(
        child: SizedBox(
            height: 200.0,
            width: 350.0,
            child: Carousel(
              images: [
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg')
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.purple.withOpacity(0.5),
              borderRadius: true,
            )),
      ),
      Container(
          //child: tableScreen(),
          )
    ],
  );
}
