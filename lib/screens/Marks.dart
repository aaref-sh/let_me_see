import 'package:flutter/material.dart';
import 'package:let_me_see/screens/GlobalVariables.dart';

class Marks extends StatefulWidget {
  @override
  _MarksState createState() => _MarksState();
}

class _MarksState extends State<Marks> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: marklist.length,
      itemBuilder: (context, index) {
        int i = marklist.length - 1 - index;
        bool ra = marklist[i].mark < 60;
        return ListTile(
          tileColor: i % 2 == 0 ? Colors.grey[200] : Colors.grey[100],
          title: Center(
              child: Text(
            marklist[i].name,
            style: TextStyle(fontSize: 20),
          )),
          trailing: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ra ? Colors.red[300] : Colors.green[300],
                border: Border.all(
                  color: ra ? Colors.red[900] : Colors.green[800],
                  width: 4,
                )),
            height: 40,
            width: 100,
            child: Center(
              child: Container(
                child: Text(
                  marklist[i].mark.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
