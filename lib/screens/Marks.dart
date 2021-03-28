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
        return Container(
            // child: Row(
            //   children: [
            //     Expanded(
            //         child: Center(
            //       child: Text(marklist[i].name),
            //     )),
            //     Expanded(
            //       child: Container(
            //         color: marklist[i].mark < 60
            //             ? Colors.red[200]
            //             : Colors.green[200],
            //         child: Center(
            //           child: Text(marklist[i].mark.toString()),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            );
      },
    );
  }
}
