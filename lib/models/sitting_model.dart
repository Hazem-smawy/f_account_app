// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SittingModel {
  int id;
  int every;
  bool isCopyOn;
  bool newData;
  SittingModel({
    required this.id,
    required this.every,
    required this.isCopyOn,
    required this.newData,
  });

  SittingModel copyWith({
    int? id,
    int? every,
    bool? isCopyOn,
    bool? newData,
  }) {
    return SittingModel(
        id: id ?? this.id,
        every: every ?? this.every,
        isCopyOn: isCopyOn ?? this.isCopyOn,
        newData: newData ?? this.newData);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'every': every,
      'isCopyOn': isCopyOn ? 1 : 0,
      "newData": newData ? 1 : 0,
    };
  }

  factory SittingModel.fromMap(Map<String, dynamic> map) {
    return SittingModel(
      id: map['id'] as int,
      every: map['every'] as int,
      isCopyOn: map['isCopyOn'] == 1,
      newData: map['newData'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory SittingModel.fromJson(String source) =>
      SittingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SittingModel(id: $id, every: $every, isCopyOn: $isCopyOn, newData: $newData)';

  @override
  bool operator ==(covariant SittingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.every == every &&
        other.isCopyOn == isCopyOn &&
        other.newData == newData;
  }

  @override
  int get hashCode =>
      id.hashCode ^ every.hashCode ^ isCopyOn.hashCode ^ newData.hashCode;
}
