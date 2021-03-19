import 'package:let_me_see/model/model.dart';

List<Lecture> lecturelist;
List<Notificate> notificationlist = <Notificate>[];
List<Doc> doclist = <Doc>[];

final url0 = "http://192.168.1.111:66/";

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json'
};

int userId;
bool isateacher;
int selectedIndex = 0;
