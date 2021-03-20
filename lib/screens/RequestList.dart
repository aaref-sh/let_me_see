import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_me_see/screens/GlobalVariables.dart';
import 'package:line_icons/line_icons.dart';

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    'قائمة الطلبات',
                    style: TextStyle(color: Colors.grey[600], fontSize: 28),
                  )),
                ))),
        Container(
          height: MediaQuery.of(context).size.height - 150,
          child: Requests(),
        )
      ],
    ));
  }
}

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  var _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return getRequestList();
  }

  Widget getRequestList() {
    int n = requestlist.length;
    var list = CupertinoScrollbar(
        controller: _scrollController,
        child: ListView.builder(
            itemCount: n,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                leading: Icon(LineIcons.fileContract),
                title: Text(requestlist[i].type),
                subtitle: Text('الحالة: ' + requestlist[i].status),
                trailing: gettrailling(i),
              );
            }));
    return list;
  }

  gettrailling(int i) {
    if (requestlist[i].status == 'مقبول')
      return Icon(Icons.check, color: Colors.green);
    if (requestlist[i].status == 'مرفوض')
      return Icon(Icons.block, color: Colors.red);
    return Icon(Icons.timer);
  }
}
