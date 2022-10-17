// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:amazon_clone/src/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Order copyWith({
    String? id,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    String? userId,
    int? orderedAt,
    int? status,
    double? totalPrice,
  }) {
    return Order(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      products: List<Product>.from(
        (map['products'] as List<Product>).map<Product>(
          (product) => Product.fromMap(product as Map<String, dynamic>),
        ),
      ),
      quantity: List<int>.from(map['quantity'] as List<int>),
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as int,
      status: map['status'] as int,
      totalPrice: map['totalPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, products: $products, quantity: $quantity, address: $address, userId: $userId, orderedAt: $orderedAt, status: $status, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.products, products) &&
        listEquals(other.quantity, quantity) &&
        other.address == address &&
        other.userId == userId &&
        other.orderedAt == orderedAt &&
        other.status == status &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        products.hashCode ^
        quantity.hashCode ^
        address.hashCode ^
        userId.hashCode ^
        orderedAt.hashCode ^
        status.hashCode ^
        totalPrice.hashCode;
  }
}
