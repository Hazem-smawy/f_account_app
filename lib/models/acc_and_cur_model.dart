// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccCurencyModel {
  final int accGroupId;
  int? curencyId;
  AccCurencyModel({
    required this.accGroupId,
    this.curencyId,
  });

  AccCurencyModel copyWith({
    int? accGroupId,
    int? curencyId,
  }) {
    return AccCurencyModel(
      accGroupId: accGroupId ?? this.accGroupId,
      curencyId: curencyId ?? this.curencyId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accGroupId': accGroupId,
      'curencyId': curencyId,
    };
  }

  factory AccCurencyModel.fromMap(Map<String, dynamic> map) {
    return AccCurencyModel(
      accGroupId: map['accGroupId'] as int,
      curencyId: map['curencyId'] != null ? map['curencyId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccCurencyModel.fromJson(String source) =>
      AccCurencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AccCurencyModel(accGroupId: $accGroupId, curencyId: $curencyId)';

  @override
  bool operator ==(covariant AccCurencyModel other) {
    if (identical(this, other)) return true;

    return other.accGroupId == accGroupId && other.curencyId == curencyId;
  }

  @override
  int get hashCode => accGroupId.hashCode ^ curencyId.hashCode;
}
