import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String text;
  LoadingPage(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.grey[600], fontSize: 30),
                  textDirection: TextDirection.rtl,
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
