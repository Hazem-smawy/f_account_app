// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SittingModel {
  int id;
  int every;
  bool isCopyOn;
  SittingModel({
    required this.id,
    required this.every,
    required this.isCopyOn,
  });

  SittingModel copyWith({
    int? id,
    int? every,
    bool? isSinckOn,
  }) {
    return SittingModel(
      id: id ?? this.id,
      every: every ?? this.every,
      isCopyOn: isSinckOn ?? isCopyOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'every': every,
      'isCopyOn': isCopyOn ? 1 : 0,
    };
  }

  factory SittingModel.fromMap(Map<String, dynamic> map) {
    return SittingModel(
      id: map['id'] as int,
      every: map['every'] as int,
      isCopyOn: map['isCopyOn'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory SittingModel.fromJson(String source) =>
      SittingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SittingModel(id: $id, every: $every, isCopyOn: $isCopyOn)';

  @override
  bool operator ==(covariant SittingModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.every == every && other.isCopyOn == isCopyOn;
  }

  @override
  int get hashCode => id.hashCode ^ every.hashCode ^ isCopyOn.hashCode;
}
