class Lecture {
  int _day;
  int _time;
  String _programName;
  String _hall;

  int get day => this._day;
  int get time => this._time;
  String get programName => this._programName;
  String get hall => this._hall;

  Lecture.fromMap(map) {
    this._time = int.parse(map['lecture_at_id'].toString());
    this._day = int.parse(map['dayinweek'].toString());
    this._programName = map['name'];
    this._hall = map['hall']['name'];
  }
}

class Notificate {
  String _author;
  String _title;
  String _description;
  int _authorId;
  int _id;

  String get author => this._author;
  String get title => this._title;
  String get description => this._description;
  int get authorId => this._authorId;
  int get id => this._id;

  Notificate.fromMap(map) {
    this._author = map['teacher']['name'];
    this._title = map['title'];
    this._id = int.parse(map['Id'].toString());
    this._description = map['description'].toString();
    this._authorId = int.parse(map['author'].toString());
  }
}

class Doc {
  int _id;
  int _ownerid;
  String _owner;
  String _name;

  Doc(this._id, this._ownerid, this._name, this._owner);

  int get id => this._id;
  int get ownerid => this._ownerid;
  String get owner => this._owner;
  String get name => this._name;

  Doc.fromMap(map) {
    this._id = map['id'];
    this._ownerid = int.parse(map['owner'].toString());
    this._name = map['path'].split('\\').last;
    this._owner = map['teacher']['name'];
  }
}

class Requst {
  int _id;
  int _typeId;
  int _statusId;
  String _type;
  String _status;

  int get id => this._id;
  int get typeId => this._typeId;
  int get statusId => this._statusId;
  String get type => this._type;
  String get status => this._status;

  Requst.fromMap(map) {
    this._id = int.parse(map['id'].toString());
    this._typeId = int.parse(map['request_type'].toString());
    this._statusId = int.parse(map['status'].toString());
    this._type = map['request_type1']['name'];
    this._status = map['status1']['status1'].toString();
  }
}
