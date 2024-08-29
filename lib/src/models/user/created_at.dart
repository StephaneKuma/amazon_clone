import 'dart:convert';

import 'package:collection/collection.dart';

class CreatedAt {
  final DateTime? datetime;
  final String? humanDiff;
  final String? human;

  const CreatedAt({this.datetime, this.humanDiff, this.human});

  @override
  String toString() {
    return 'CreatedAt(datetime: $datetime, humanDiff: $humanDiff, human: $human)';
  }

  factory CreatedAt.fromMap(Map<String, dynamic> data) => CreatedAt(
        datetime: data['datetime'] == null
            ? null
            : DateTime.parse(data['datetime'] as String),
        humanDiff: data['humanDiff'] as String?,
        human: data['human'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'datetime': datetime?.toIso8601String(),
        'humanDiff': humanDiff,
        'human': human,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreatedAt].
  factory CreatedAt.fromJson(String data) {
    return CreatedAt.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreatedAt] to a JSON string.
  String toJson() => json.encode(toMap());

  CreatedAt copyWith({
    DateTime? datetime,
    String? humanDiff,
    String? human,
  }) {
    return CreatedAt(
      datetime: datetime ?? this.datetime,
      humanDiff: humanDiff ?? this.humanDiff,
      human: human ?? this.human,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CreatedAt) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => datetime.hashCode ^ humanDiff.hashCode ^ human.hashCode;
}
