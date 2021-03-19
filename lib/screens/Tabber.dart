import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/DocList.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:line_icons/line_icons.dart';

import 'GlobalVariables.dart';

class Tabber extends StatefulWidget {
  @override
  _TabberState createState() => _TabberState();
}

class _TabberState extends State<Tabber> {
  TextEditingController titlecontroller;
  TextEditingController descrcontroller;

  @override
  void initState() {
    super.initState();
    titlecontroller = TextEditingController()..addListener(() {});
    descrcontroller = TextEditingController()..addListener(() {});
  }

  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      Container(
        child: Text('rqs'),
      ),
      SafeArea(
          child: Column(
        children: [
          Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                  )),
                  child: Center(
                      child: Text(
                    'قائمة الإعلانات',
                    style: TextStyle(color: Colors.grey[800], fontSize: 20),
                  )))),
          Container(
            height: MediaQuery.of(context).size.height - 125,
            child: Notifications(),
          )
        ],
      )),
      DocList(),
    ];
    return Scaffold(
      floatingActionButton: floatingb(),
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
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
                  GButton(icon: LineIcons.home, text: 'الرئيسية'),
                  GButton(icon: LineIcons.fileInvoice, text: 'الطلبات'),
                  GButton(icon: LineIcons.bullhorn, text: 'الإعلانات'),
                  GButton(icon: LineIcons.pdfFile, text: 'المحاضرات'),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }

  var tooltips = ['إضافة إخطار', 'رفع ملف'];
  var icons = [Icon(Icons.notifications_active), Icon(LineIcons.fileUpload)];
  Widget floatingb() {
    if (isateacher && selectedIndex > 1)
      return FloatingActionButton(
        onPressed: () {
          doit();
        },
        backgroundColor: Colors.grey[700],
        tooltip: tooltips[selectedIndex - 2],
        child: icons[selectedIndex - 2],
      );
    if (selectedIndex == 1 && !isateacher)
      return FloatingActionButton(
        onPressed: () {},
        tooltip: "طلب وثيقة",
        child: Icon(LineIcons.paperHand),
      );
    return null;
  }

  doit() async {
    if (selectedIndex == 3) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        for (var i in files) {
          print(i.path.split("/").last);
          await uploadFile(i);
        }
      }
    } else {
      createNotification();
    }
    setState(() {});
  }

  createNotification() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('نشر إخطار للطلاب'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                Text('نشر إخطار للطلاب'),
                TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'العنوان',
                    )),
                Spacer(),
                TextField(
                    controller: descrcontroller,
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الوصف',
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('نشر'),
              onPressed: () async {
                var url = url0 + 'api/values/addnotification';
                var body = json.encode({
                  'author': userId,
                  'title': titlecontroller.text,
                  'description': descrcontroller.text
                });
                var response;
                try {
                  response = await http
                      .post(Uri.parse(url), body: body, headers: headers)
                      .timeout(Duration(seconds: 10), onTimeout: () {
                    showMaterialDialog(3, context);
                    return;
                  });
                  updatenotificationlist();
                } catch (e) {
                  if (response.statusCode != 204) {
                    showMaterialDialog(3, context);
                    return;
                  }
                }
                setState(() {
                  print(response.body);
                });
              },
            ),
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  uploadFile(File f) async {
    var postUri = Uri.parse(url0 + "api/values/upload/$userId");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath(f.path.split("/").last, f.path);
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    await updatedoclist();
    response.statusCode == 200
        ? showMaterialDialog(0, context)
        : showMaterialDialog(1, context);
    print(response.statusCode);
  }
}

showMaterialDialog(i, context) {
  var msgs = [
    'تم رفع الملفات ✔',
    'فشل رفع الملفات ⚠',
    'فشل حذف الملفات',
    'لا يمكن الوصول للخادم'
  ];
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(msgs[i]),
            actions: <Widget>[
              TextButton(
                child: Text('تم'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
