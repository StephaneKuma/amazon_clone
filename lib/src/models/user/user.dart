import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'created_at.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? lastName;
  @HiveField(4)
  final String? firstName;
  @HiveField(5)
  final String? birthday;
  @HiveField(6)
  final String? gender;
  @HiveField(7)
  final String? role;
  @HiveField(8)
  final String? token;

  const User({
    this.id,
    this.email,
    this.phone,
    this.lastName,
    this.firstName,
    this.birthday,
    this.gender,
    this.role,
    this.token,
  });

  @override
  String toString() {
    return 'User(id: $id, email: $email, phone: $phone, lastName: $lastName, firstName: $firstName, birthday: $birthday, gender: $gender, role: $role,)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        lastName: data['lastName'] as String?,
        firstName: data['firstName'] as String?,
        birthday: data['birthday'] as String?,
        gender: data['gender'] as String?,
        role: data['role'] as String?,
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
        'last_name': lastName,
        'first_name': firstName,
        'birthday': birthday,
        'gender': gender,
        'role': 'customer',
        'password': "password",
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? lastName,
    String? firstName,
    String? birthday,
    String? gender,
    String? role,
    String? token,
    CreatedAt? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      lastName.hashCode ^
      firstName.hashCode ^
      birthday.hashCode ^
      gender.hashCode ^
      role.hashCode ^
      token.hashCode;
}
