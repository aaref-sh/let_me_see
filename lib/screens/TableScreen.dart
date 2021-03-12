import 'package:flutter/material.dart';
import 'Home.dart';

class TableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 6,
      children: [
        Container(
            color: Colors.grey[700],
            child: Center(child: Text('الوقت', style: ts))),
        Container(
            color: Colors.grey, child: Center(child: Text('الأحد', style: ts))),
        Container(
            color: Colors.grey,
            child: Center(child: Text('الاثنين', style: ts))),
        Container(
            color: Colors.grey,
            child: Center(child: Text('الثلاثاء', style: ts))),
        Container(
            color: Colors.grey,
            child: Center(child: Text('الأربعاء', style: ts))),
        Container(
            color: Colors.grey,
            child: Center(child: Text('الخميس', style: ts))),
        Container(
            color: Colors.grey[700],
            child: Center(child: Text('8:00', style: ts))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح1'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح2'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح3'))),
        Container(color: Colors.grey[300], child: Center(child: Text('non'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح5'))),
        Container(
            color: Colors.grey[700],
            child: Center(child: Text('10:00', style: ts))),
        Center(child: Text('مح1')),
        Center(child: Text('مح2')),
        Center(child: Text('non')),
        Center(child: Text('مح3')),
        Center(child: Text('مح5')),
        Container(
            color: Colors.grey[700],
            child: Center(child: Text('12:00', style: ts))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح1'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح2'))),
        Container(color: Colors.grey[300], child: Center(child: Text('non'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح3'))),
        Container(color: Colors.grey[300], child: Center(child: Text('مح5'))),
        Container(
            color: Colors.grey[700],
            child: Center(child: Text('10:00', style: ts))),
        Center(child: Text('non')),
        Center(child: Text('مح1')),
        Center(child: Text('مح2')),
        Center(child: Text('مح3')),
        Center(child: Text('مح5')),
      ],
    );
  }
}
