// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:amazon_clone/src/models/rating.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final List<Rating>? ratings;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.ratings,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    List<String>? images,
    String? category,
    double? price,
    List<Rating>? ratings,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'ratings': ratings
          ?.map(
            (Rating rating) => rating.toMap(),
          )
          .toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as double,
      images: List<String>.from(map['images'] as List<String>),
      category: map['category'] as String,
      price: map['price'] as double,
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              (map['ratings'] as List<Rating>).map<Rating?>(
                (rating) => Rating.fromMap(rating as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, quantity: $quantity, images: $images, category: $category, price: $price, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.quantity == quantity &&
        listEquals(other.images, images) &&
        other.category == category &&
        other.price == price &&
        listEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        images.hashCode ^
        category.hashCode ^
        price.hashCode ^
        ratings.hashCode;
  }
}
