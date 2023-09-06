// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccGroupField {
   static const String id = 'id';
  static const String name = 'name';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';

    static final List<String> values = [
    id,
    name,
    status,
    createdAt,
    modifiedAt,
  ];
}
class AccGroup {
   int? id;
  final String name;
  final bool status;
  final DateTime createdAt;
  final DateTime modifiedAt;
  AccGroup({
     this.id ,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  AccGroup copyWith({
    int? id,
    String? name,
    bool? status,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) {
    return AccGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createAt ?? createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }


  Map<String, dynamic> toEditMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status ,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }

  factory AccGroup.fromMap(Map<String, Object?> map) {
    return AccGroup(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      modifiedAt: DateTime.parse(map['modifiedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccGroup.fromJson(String source) => AccGroup.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccGroup(id: $id, name: $name, status: $status, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(covariant AccGroup other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      modifiedAt.hashCode;
  }
}
