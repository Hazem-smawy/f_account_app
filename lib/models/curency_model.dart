// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurencyField {
  static const String id = 'id';
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';

  static final List<String> values = [
    id,
    name,
    symbol,
    status,
    createdAt,
    modifiedAt,
  ];
}

class Curency {
   int? id;
  final String name;
  final String symbol;
  final bool status;
  final DateTime createdAt;
  final DateTime modifiedAt;
  Curency({
     this.id,
    required this.name,
    required this.symbol,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  Curency copyWith({
    int? id,
    String? name,
    String? symbol,
    bool? status,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Curency(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
      'status': status ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }
    Map<String, dynamic> toEditMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
      'status': status ,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }

  factory Curency.fromMap(Map<String, dynamic> map) {
    return Curency(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      status: map['status'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      modifiedAt: DateTime.parse(map['modifiedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Curency.fromJson(String source) =>
      Curency.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Curency(id: $id, name: $name,symbol:$symbol, status: $status, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(covariant Curency other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode;
  }
}
