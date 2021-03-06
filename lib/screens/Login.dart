import 'dart:convert';
import 'package:let_me_see/screens/ApiConnection.dart';
import 'package:let_me_see/screens/GlobalVariables.dart';
import 'package:let_me_see/screens/LoadingPage.dart';
import 'package:let_me_see/screens/LoginTeacher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/Home.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idcontroller;
  TextEditingController passwordcontroller;

  @override
  void initState() {
    super.initState();
    read();
    passwordcontroller = new TextEditingController()..addListener(() {});
    idcontroller = new TextEditingController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    Column widget = Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
              textDirection: TextDirection.ltr,
              controller: idcontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'الرقم الجامعي',
                  icon: Icon(
                    Icons.person,
                  ))),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'كلمة المرور',
                  icon: Icon(
                    Icons.vpn_key,
                  ))),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey[600],
            textStyle: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => checkinput(),
          child: Row(
            children: [
              Expanded(child: Container()),
              Text('تسجيل الدخول'),
              Icon(Icons.arrow_forward_ios_outlined),
              Expanded(
                  child: TextButton(
                child: Text('دخول كمدرس'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginTeacherPage()),
                  );
                },
              )),
            ],
          ),
        )
      ],
    );
    if (val == null) return LoadingPage('جاري التحقق من المستخدم...');
    if (val != 0) return ApiConnection(userId: val, isateacher: isateacher);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/login_back.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Container(
              child: Carde(
                text: Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                widget: widget,
                height: 170.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkinput() async {
    String id = idcontroller.text;
    String password = passwordcontroller.text;
    final url = Uri.parse(url0 + 'api/values/signin');
    final body = json.encode({'Id': id, 'password': password});
    try {
      var response = await http
          .post(url, body: body, headers: headers)
          .timeout(Duration(seconds: 10), onTimeout: () {
        return;
      });
      bool jsonData = json.decode(response.body);

      if (jsonData == true) {
        save(int.parse(id), false);
        setState(() {});
        return null;
      }
      alert(context, false);
    } catch (e) {
      alert(context, true);
    }
    setState(() {});
  }

  void alert(context, x) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(x ? "لا يمكن الاتصال بالخادم" : "بيانات دخول خاطئة"),
            content: Text(x
                ? "لا يمكن الوصول للخادم! تأكد من اتصالك بالانترنت"
                : "لديك خطأ في إدخال الرقم الجامعي أو كلمة المرور"),
          ));

  int val;
  bool isateacher;
  save(id, type) async {
    final prefs = await SharedPreferences.getInstance();
    val = id;
    isateacher = type;
    prefs.setInt('id', val);
    prefs.setBool('isateacher', type);
    print('saved $val');
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    val = prefs.getInt(key) ?? 0;
    isateacher = prefs.getBool('isateacher');
    print('read: $val');
    setState(() {});
  }
}
