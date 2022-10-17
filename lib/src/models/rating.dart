// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  final String id;
  final String userId;
  final double value;

  Rating({
    required this.id,
    required this.userId,
    required this.value,
  });

  Rating copyWith({
    String? id,
    String? userId,
    double? value,
  }) {
    return Rating(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'value': value,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rating(id: $id, userId: $userId, value: $value)';

  @override
  bool operator ==(covariant Rating other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ value.hashCode;
}
