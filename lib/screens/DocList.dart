import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ApiConnection.dart';
import 'GlobalVariables.dart';
import 'package:http/http.dart' as http;

class DocList extends StatefulWidget {
  @override
  _DocListState createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SafeArea(
            child: Column(
          children: [
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 70,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: Center(
                          child: Text(
                        'ملفات المحاضرات الالكترونية',
                        style: TextStyle(color: Colors.grey[600], fontSize: 28),
                      )),
                    ))),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: doclistbuilder(),
            )
          ],
        )),
      ),
    );
  }

  doclistbuilder() {
    var list = ListView.builder(
        itemCount: doclist.length + 1,
        itemBuilder: (context, i) {
          if (i == doclist.length) return Container(height: 75);
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
              if (isateacher || doclist[i].ownerid == userId)
                deleteConfirmationDialog(doclist[i].id);
            },
          );
        });
    return list;
  }

  deleteConfirmationDialog(id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('هل تريد بالتأكيد حذف الملف؟'),
          content: Text('لا يمكنك التراجع بعد الحذف'),
          actions: <Widget>[
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                deletefile(id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  deletefile(int id) async {
    if (doclist.where((element) => element.id == id).first.ownerid != userId)
      return;
    var url = url0 + 'api/values/deletedoc/$id';
    var response;
    try {
      response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10),
          onTimeout: () {
        showMaterialDialog(3, context);
        return;
      });
    } catch (e) {
      if (response.statusCode != 204) {
        showMaterialDialog(2, context);
        return;
      }
    }
    setState(() {
      doclist.removeWhere((element) => element.id == id);
      print(response.body);
    });
  }

  downloadfile(int i) async {
    String url = url0 + "Home/Download/$i";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}

uploadFile(File f, context) async {
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
