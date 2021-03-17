import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:let_me_see/screens/TableScreen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

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
    PickFile(),
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

class PickFile extends StatefulWidget {
  @override
  _PickFileState createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          child: Text('اختر ملف'),
          onPressed: () async {
            FilePickerResult result =
                await FilePicker.platform.pickFiles(allowMultiple: true);
            if (result != null) {
              List<File> files =
                  result.paths.map((path) => File(path)).toList();
              for (var i in files) {
                print(i.path.split("/").last);
                uploadFile(i);
              }
            } else {
              // User canceled the picker
            }
          },
        ),
      ),
    );
  }
}

uploadFile(File f) async {
  // var postUri = Uri.parse("apiUrl");
  // http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
  // http.MultipartFile multipartFile =
  //     await http.MultipartFile.fromPath(f.path.split("/").last, f.path);
  // request.files.add(multipartFile);
  // http.StreamedResponse response = await request.send();
  // print(response.statusCode);
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://192.168.1.111:66/api/values/ups'));
  request.files.add(await http.MultipartFile.fromPath('docc', f.path));
  var res = await request.send();
  print(res.reasonPhrase);
  // var request = new http.MultipartRequest("POST", Uri.parse(''));
  // // request.fields['user'] = 'someone@somewhere.com';
  // request.files.add(await http.MultipartFile.fromPath(
  //   f.path.split('/').last,
  //   f.path,
  //   contentType: MediaType('application', 'pdf'),
  // ));
  // request.send().then((response) {
  //   if (response.statusCode == 200) print("Uploaded!");
  // });
}
