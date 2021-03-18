import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:let_me_see/model/model.dart';
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:let_me_see/screens/TableScreen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

final _url = "http://192.168.1.111:66/";

List<Lecture> lecturelist;
List<Notificate> notificationlist = <Notificate>[];
List<Doc> doclist = <Doc>[];

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
    DocList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingb(),
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

  var tooltips = ['إضافة إخطار', 'رفع ملف'];
  var icons = [Icon(Icons.notifications_active), Icon(LineIcons.fileUpload)];
  Widget floatingb() {
    if (!isateacher || _selectedIndex < 2) return null;
    return FloatingActionButton(
      onPressed: () {
        doit();
      },
      tooltip: tooltips[_selectedIndex - 2],
      child: icons[_selectedIndex - 2],
    );
  }

  doit() async {
    if (_selectedIndex == 3) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        for (var i in files) {
          print(i.path.split("/").last);
          await uploadFile(i);
          setState(() {});
        }
      } else {
        // User canceled the picker
      }
    }
  }
}

class DocList extends StatefulWidget {
  @override
  _DocListState createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: doclistbuilder(),
        ),
      ),
    );
  }

  doclistbuilder() {
    var list = ListView.builder(
        itemCount: doclist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(LineIcons.pdfFile),
            title: Text(doclist[i].name),
            subtitle: Text('بواسطة ${doclist[i].owner}'),
            trailing: IconButton(
              icon: Icon(LineIcons.download),
              onPressed: () {
                downloadfile(doclist[i].id);
              },
            ),
            onLongPress: () {
              deletefile(doclist[i].id);
            },
          );
        });
    return list;
  }

  deletefile(int id) async {
    if (doclist.where((element) => element.id == id).first.ownerid != userId)
      return;
    var url = _url + 'api/values/deletedoc/$id';
    var response = await http.get(Uri.parse(url));
    setState(() {
      doclist.removeWhere((element) => element.id == id);
      print(response.body);
    });
  }

  downloadfile(int i) async {
    String url = _url + "Home/Download/$i";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}

uploadFile(File f) async {
  var postUri = Uri.parse(_url + "api/values/upload/$userId");
  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath(f.path.split("/").last, f.path);
  request.files.add(multipartFile);
  http.StreamedResponse response = await request.send();
  await updatedoclist();

  print(response.statusCode);
}
