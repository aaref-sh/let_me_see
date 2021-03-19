import 'package:flutter/material.dart';
import 'GlobalVariables.dart';
import 'Home.dart';

List<String> times = ['8:00 ص', '10:00 ص', '12:00 م', '2:00 م', '4:00 م'];
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
                child: Center(child: Text(ss[i], style: ts)));
          if (i % 6 == 0)
            return Container(
                color: Colors.grey[700],
                child: Center(child: Text(times[time - 1], style: ts)));

          String txt;
          try {
            txt = lecturelist
                .firstWhere(
                    (element) => element.day == day && element.time == time)
                .programName;
          } catch (e) {
            txt = 'فراغ';
          }

          Color ths = time % 2 == 0 ? Colors.grey[300] : Colors.white;
          return Container(
              color: ths,
              child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Center(child: Text(txt))));
        }));
  }
}
