// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerField {
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';

  static final List<String> values = [
    id,
    name,
    phone,
    address,
    status,
    createdAt,
    modifiedAt,
  ];
}

class Customer {
  int? id;
  final String name;
  final String phone;
  final String address;
  final bool status;
  final DateTime createdAt;
  final DateTime modifiedAt;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    bool? status,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'status': status ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toEditMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      status: map['status'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
      modifiedAt: DateTime.parse(map['modifiedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, phone: $phone, address: $address, status: $status, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode;
  }
}
