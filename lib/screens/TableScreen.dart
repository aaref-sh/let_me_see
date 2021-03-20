import 'package:flutter/material.dart';
import 'package:let_me_see/model/model.dart';
import 'GlobalVariables.dart';

List<String> times = ['8:30 ص', '10:00 ص', '11:30 ص', '1:00 م', '2:30 م'];
List<String> ss = [
  'الوقت',
  'الأحد',
  'الاثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس'
];

class TableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 6,
        children: List.generate(36, (i) {
          int time = (i / 6).floor();
          int day = i % 6;
          if (i < 6)
            return Container(
                color: i == 0 ? Colors.grey[700] : Colors.grey,
                child: Center(
                    child: Text(ss[i], style: TextStyle(color: Colors.white))));
          if (i % 6 == 0)
            return Container(
                color: Colors.grey[700],
                child: Center(
                    child: Text(times[time - 1],
                        style: TextStyle(color: Colors.white))));

          Widget lec;
          try {
            Lecture l = lecturelist.firstWhere(
                (element) => element.day == day && element.time == time);
            lec = GestureDetector(
              child: Text(l.programName),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(title: Text(l.hall)));
              },
            );
          } catch (e) {
            lec = Text('فراغ');
          }

          Color ths = time % 2 == 0 ? Colors.grey[300] : Colors.white;
          return Container(
              color: ths,
              child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Center(child: lec)));
        }));
  }
}
