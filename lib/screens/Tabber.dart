import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/DocList.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:let_me_see/screens/Marks.dart';
import 'package:let_me_see/screens/Notifications.dart';
import 'package:let_me_see/screens/RequestList.dart';
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
      if (!isateacher) RequestList(),
      if (isateacher) NotificationList(),
      if (!isateacher) Marks(),
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
                  if (!isateacher)
                    GButton(icon: LineIcons.fileInvoice, text: 'الطلبات'),
                  GButton(icon: LineIcons.checkCircle, text: 'النتائج'),
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
    if (isateacher && selectedIndex > 0)
      return FloatingActionButton(
        onPressed: () => doit(),
        backgroundColor: Colors.grey[700],
        tooltip: tooltips[selectedIndex - 1],
        child: icons[selectedIndex - 1],
      );
    if (selectedIndex == 1 && !isateacher)
      return FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
                            onChanged: (newValue) {
                              setState(() => dropdownValue = newValue);
                            },
                            items: spinnerItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                          )
                        ],
                      );
                    },
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          try {
                            var url = Uri.parse(url0 +
                                'api/values/addrequest?s=$dropdownValue');
                            var body =
                                json.encode({"requester": userId, "status": 1});
                            var response = await http
                                .post(url, body: body, headers: headers)
                                .timeout(Duration(seconds: 10), onTimeout: () {
                              showMaterialDialog(3, context);
                            });
                            print(json.decode(response.body));
                          } catch (_) {}
                          Navigator.pop(context);
                          await updaterequestlist();
                          setState(() {});
                        },
                        child: Text('طلب')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('إلغاء'))
                  ],
                );
              });
        },
        tooltip: "طلب وثيقة",
        child: Icon(LineIcons.fileContract),
      );
    return null;
  }

  doit() async {
    if (selectedIndex == 2) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path)).toList();
        for (var i in files) {
          print(i.path.split("/").last);
          await uploadFile(i, context);
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
                if (titlecontroller.text != null) if (titlecontroller.text !=
                    "") {
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
                }
                titlecontroller.text = descrcontroller.text = "";
                Navigator.pop(context);
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
}
