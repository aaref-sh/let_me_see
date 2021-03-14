class Lecture {
  int _day;
  int _time;
  String _programName;

  int get day => this._day;
  int get time => this._time;
  String get programName => this._programName;

  Lecture(this._day, this._programName, this._time);

  Lecture.fromMap(map) {
    this._time = int.parse(map['lecture_at_id'].toString());
    this._day = int.parse(map['dayinweek'].toString());
    this._programName = map['name'];
  }
}

class Notificate {
  String _author;
  String _title;
  String _description;

  String get author => this._author;
  String get title => this._title;
  String get description => this._description;

  Notificate.fromMap(map) {
    this._author = map['teacher']['name'];
    this._title = map['title'];
    this._description = map['description'];
  }
}
