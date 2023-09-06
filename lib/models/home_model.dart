// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeModel {
  final int? caId;
  final int? cacId;
  final int operation;
  final int? accGId;
  final int? curId;
  final String name;
  final bool caStatus;
  final bool cacStatus;
  final double totalDebit;
  final double totalCredit;
  HomeModel({
    this.caId,
    this.cacId,
    required this.operation,
    this.accGId,
    this.curId,
    required this.name,
    required this.caStatus,
    required this.cacStatus,
    required this.totalDebit,
    required this.totalCredit,
  });

  HomeModel copyWith({
    int? caId,
    int? cacId,
    int? operation,
    int? accGId,
    int? curId,
    String? name,
    bool? caStatus,
    bool? cacStatus,
    double? totalDebit,
    double? totalCredit,
  }) {
    return HomeModel(
      caId: caId ?? this.caId,
      cacId: cacId ?? this.cacId,
      operation: operation ?? this.operation,
      accGId: accGId ?? this.accGId,
      curId: curId ?? this.curId,
      name: name ?? this.name,
      caStatus: caStatus ?? this.caStatus,
      cacStatus: cacStatus ?? this.cacStatus,
      totalDebit: totalDebit ?? this.totalDebit,
      totalCredit: totalCredit ?? this.totalCredit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caId': caId,
      'cacId': cacId,
      'operation': operation,
      'accGId': accGId,
      'curId': curId,
      'name': name,
      'caStatus': caStatus ? 1 : 0,
      'cacStatus': cacStatus ? 1 : 0,
      'totalDebit': totalDebit,
      'totalCredit': totalCredit,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      caId: map['caId'] != null ? map['caId'] as int : null,
      cacId: map['cacId'] != null ? map['cacId'] as int : null,
      operation: map['operation'] as int,
      accGId: map['accGId'] != null ? map['accGId'] as int : null,
      curId: map['curId'] != null ? map['curId'] as int : null,
      name: map['name'] as String,
      caStatus: map['caStatus'] == 1,
      cacStatus: map['cacStatus'] == 1,
      totalDebit: map['totalDebit'] as double,
      totalCredit: map['totalCredit'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeModel(caId: $caId, cacId: $cacId, operation: $operation, accGId: $accGId, curId: $curId, name: $name, caStatus: $caStatus, cacStatus: $cacStatus, totalDebit: $totalDebit, totalCredit: $totalCredit)';
  }

  @override
  bool operator ==(covariant HomeModel other) {
    if (identical(this, other)) return true;

    return other.caId == caId &&
        other.cacId == cacId &&
        other.operation == operation &&
        other.accGId == accGId &&
        other.curId == curId &&
        other.name == name &&
        other.caStatus == caStatus &&
        other.cacStatus == cacStatus &&
        other.totalDebit == totalDebit &&
        other.totalCredit == totalCredit;
  }

  @override
  int get hashCode {
    return caId.hashCode ^
        cacId.hashCode ^
        operation.hashCode ^
        accGId.hashCode ^
        curId.hashCode ^
        name.hashCode ^
        caStatus.hashCode ^
        cacStatus.hashCode ^
        totalDebit.hashCode ^
        totalCredit.hashCode;
  }
}

class GroupCurency {
  int? crId;
  final String name;
  final String symbol;
  GroupCurency({
    this.crId,
    required this.name,
    required this.symbol,
  });

  GroupCurency copyWith({
    int? crId,
    String? name,
    String? symbol,
  }) {
    return GroupCurency(
      crId: crId ?? this.crId,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'crId': crId,
      'name': name,
      'symbol': symbol,
    };
  }

  factory GroupCurency.fromMap(Map<String, dynamic> map) {
    return GroupCurency(
      crId: map['crId'] != null ? map['crId'] as int : null,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupCurency.fromJson(String source) =>
      GroupCurency.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GroupCurency(crId: $crId, name: $name, symbol: $symbol)';

  @override
  bool operator ==(covariant GroupCurency other) {
    if (identical(this, other)) return true;

    return other.crId == crId && other.name == name && other.symbol == symbol;
  }

  @override
  int get hashCode => crId.hashCode ^ name.hashCode ^ symbol.hashCode;
}
