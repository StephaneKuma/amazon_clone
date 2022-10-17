import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String token;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.cart,
  });

  User copyWith({
    String? id,
    String? token,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      token: map['token'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      cart: List<dynamic>.from(map['cart'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, token: $token, name: $name, email: $email, password: $password, address: $address, type: $type, cart: $cart)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.token == token &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.address == address &&
      other.type == type &&
      listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      token.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      type.hashCode ^
      cart.hashCode;
  }
}
