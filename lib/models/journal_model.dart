// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JournalField {
  static const String id = 'id';
  static const String customerAccountId = 'customerAccountId';
  static const String details = 'details';
  static const String registeredAt = 'registeredAt';
  static const String credit = 'credit';
  static const String debit = 'debit';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';
  static final List<String> values = [
    id,
    customerAccountId,
    details,
    registeredAt,
    credit,
    debit,
    createdAt,
    modifiedAt,
  ];
}

class Journal {
  int? id;
  final int customerAccountId;
  final String details;
  final DateTime registeredAt;
  final double credit;
  final double debit;
  final DateTime createdAt;
  final DateTime modifiedAt;
  Journal({
    this.id,
    required this.customerAccountId,
    required this.details,
    required this.registeredAt,
    required this.credit,
    required this.debit,
    required this.createdAt,
    required this.modifiedAt,
  });

  Journal copyWith({
    int? id,
    int? customerAccountId,
    String? details,
    DateTime? registeredAt,
    double? credit,
    double? debit,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Journal(
      id: id ?? this.id,
      customerAccountId: customerAccountId ?? this.customerAccountId,
      details: details ?? this.details,
      registeredAt: registeredAt ?? this.registeredAt,
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerAccountId': customerAccountId,
      'details': details,
      'registeredAt': registeredAt.toIso8601String(),
      'credit': credit,
      'debit': debit,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'] as int,
      customerAccountId: map['customerAccountId'] as int,
      details: map['details'] as String,
      registeredAt: DateTime.parse(map['registeredAt'] as String),
      credit: map['credit'] as double,
      debit: map['debit'] as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
      modifiedAt: DateTime.parse(map['modifiedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Journal.fromJson(String source) =>
      Journal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Journal(id: $id, customerAccountId: $customerAccountId, details: $details, registeredAt: $registeredAt, credit: $credit, debit: $debit, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(covariant Journal other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerAccountId == customerAccountId &&
        other.details == details &&
        other.registeredAt == registeredAt &&
        other.credit == credit &&
        other.debit == debit &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerAccountId.hashCode ^
        details.hashCode ^
        registeredAt.hashCode ^
        credit.hashCode ^
        debit.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode;
  }
}
