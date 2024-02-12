// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonalField {
  static const String id = "id";
  static const String name = "name";
  static const String email = "email";
  static const String address = "address";
  static const String phone = "phone";
  static const String isPersonal = "isPersonal";
  static const String isSelectedAccountType = 'isSelectedAccountType';

  static final List<String> values = [
    id,
    name,
    email,
    address,
    phone,
    isPersonal,
    isSelectedAccountType,
  ];
}

class PersonalModel {
  int id;
  String name;
  String email;
  String address;
  String phone;
  bool isPersonal;
  bool isSelectedAccountType;
  PersonalModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.isPersonal,
    required this.isSelectedAccountType,
  });

  PersonalModel copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
    String? phone,
    bool? isPersonal,
    bool? isSelectedAccountType,
  }) {
    return PersonalModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        isPersonal: isPersonal ?? this.isPersonal,
        isSelectedAccountType:
            isSelectedAccountType ?? this.isSelectedAccountType);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'isPersonal': isPersonal ? 1 : 0,
      'isSelectedAccountType': isSelectedAccountType ? 1 : 0,
    };
  }

  factory PersonalModel.fromMap(Map<String, dynamic> map) {
    return PersonalModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      isPersonal: map['isPersonal'] == 1,
      isSelectedAccountType: map['isSelectedAccountType'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalModel.fromJson(String source) =>
      PersonalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonalModel(id: $id, name: $name, email: $email, address: $address, phone: $phone, isPersonal :$isPersonal, isSelectedAccountType : $isSelectedAccountType)';
  }

  @override
  bool operator ==(covariant PersonalModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.address == address &&
        other.phone == phone &&
        other.isPersonal == isPersonal &&
        other.isSelectedAccountType == isSelectedAccountType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        isPersonal.hashCode ^
        isSelectedAccountType.hashCode;
  }
}
