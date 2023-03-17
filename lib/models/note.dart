class Note {
  int? id;
  late String name;
  late String date;
  late String notes;
  late int position;

  Note(
      {required this.name,
      required this.date,
      required this.notes,
      required this.position});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['date'] = date;
    map['notes'] = notes;
    map['position'] = position;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    date = map['date'];
    notes = map['notes'];
    position = map['position'];
  }
}
