// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlertModelFiled {
  static const String id = 'id';

  static const String date = 'date';
  static const String name = 'name';
  static const String note = 'note';
  static const String isDone = 'isDone';
  static const String createdAt = 'createdAt';

  static final List<String> values = [
    id,
    name,
    date,
    note,
    createdAt,
    isDone,
  ];
}

class AlertModel {
  int? id;
  final DateTime date;
  final String name;
  final String note;
  final bool isDone;
  final DateTime createdAt;
  AlertModel({
    this.id,
    required this.date,
    required this.name,
    required this.note,
    required this.isDone,
    required this.createdAt,
  });

  AlertModel copyWith({
    int? id,
    DateTime? date,
    String? name,
    String? note,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return AlertModel(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'name': name,
      'note': note,
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      name: map['name'] as String,
      note: map['note'] as String,
      isDone: map['isDone'] == 1 as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertModel.fromJson(String source) =>
      AlertModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlertModel(id: $id, date: $date, name: $name, note: $note, isDone: $isDone, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant AlertModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.name == name &&
        other.note == note &&
        other.isDone == isDone &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        name.hashCode ^
        note.hashCode ^
        isDone.hashCode ^
        createdAt.hashCode;
  }
}
