// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/*
SELECT cac.customerId AS caId, ca.name ,cac.id AS cacId,totalDebit ,cac.totalCredit , cac.operation FROM customeraccount AS cac  JOIN  customer AS ca ON cac.customerId = ca.id

*/
class CustomerAccountField {
  static const String id = 'id';
  static const String customerId = 'customerId';
  static const String curencyId = 'curencyId';
  static const String accgroupId = 'accgroupId';
  static const String totalCredit = 'totalCredit';
  static const String totalDebit = 'totalDebit';
  static const String createdAt = 'createdAt';
  static const String operation = "operation";
  static const String status = "status";

  static final List<String> values = [
    id,
    customerId,
    curencyId,
    accgroupId,
    totalCredit,
    totalDebit,
    createdAt,
    operation,
    status
  ];
}

class CustomerAccount {
  int? id;
  final int customerId;
  final int curencyId;
  final int accgroupId;
  final double totalCredit;
  final double totalDebit;
  final DateTime createdAt;
  final int operation;
  final bool status;

  CustomerAccount(
      {this.id,
      required this.customerId,
      required this.curencyId,
      required this.accgroupId,
      required this.totalCredit,
      required this.totalDebit,
      required this.createdAt,
      required this.operation,
      required this.status});

  CustomerAccount copyWith(
      {int? id,
      int? customerId,
      int? curencyId,
      int? accgroupId,
      double? totalCredit,
      double? totalDebit,
      DateTime? createdAt,
      int? operation,
      bool? status}) {
    return CustomerAccount(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        curencyId: curencyId ?? this.curencyId,
        accgroupId: accgroupId ?? this.accgroupId,
        totalCredit: totalCredit ?? this.totalCredit,
        totalDebit: totalDebit ?? this.totalDebit,
        createdAt: createdAt ?? this.createdAt,
        operation: operation ?? this.operation,
        status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'curencyId': curencyId,
      'accgroupId': accgroupId,
      'totalCredit': totalCredit,
      'totalDebit': totalDebit,
      'createdAt': createdAt.toIso8601String(),
      'operation': operation,
      'status': status ? 1 : 0,
    };
  }

  factory CustomerAccount.fromMap(Map<String, dynamic> map) {
    return CustomerAccount(
        id: map['id'] as int,
        customerId: map['customerId'] as int,
        curencyId: map['curencyId'] as int,
        accgroupId: map['accgroupId'] as int,
        totalCredit: map['totalCredit'] as double,
        totalDebit: map['totalDebit'] as double,
        createdAt: DateTime.parse(map['createdAt'] as String),
        operation: map['operation'] as int,
        status: map['status'] == 1);
  }

  String toJson() => json.encode(toMap());

  factory CustomerAccount.fromJson(String source) =>
      CustomerAccount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerAccount(id: $id, customerId: $customerId, curencyId: $curencyId, accgroupId: $accgroupId, totalCredit: $totalCredit, totalDebit: $totalDebit, createdAt: $createdAt,operation:$operation,status:$status)';
  }

  @override
  bool operator ==(covariant CustomerAccount other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerId == customerId &&
        other.curencyId == curencyId &&
        other.accgroupId == accgroupId &&
        other.totalCredit == totalCredit &&
        other.totalDebit == totalDebit &&
        other.createdAt == createdAt &&
        other.operation == operation &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        curencyId.hashCode ^
        accgroupId.hashCode ^
        totalCredit.hashCode ^
        totalDebit.hashCode ^
        createdAt.hashCode ^
        operation.hashCode ^
        status.hashCode;
  }
}
