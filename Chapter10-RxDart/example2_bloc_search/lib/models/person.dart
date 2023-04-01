import 'package:flutter/foundation.dart' show immutable;

import 'models.dart';

@immutable
class Person extends Thing {
  final int age;
  const Person({
    required super.name,
    required this.age,
  });

  @override
  String toString() => 'Person(name: $name, age: $age)';

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(name: json['name'], age: json['age'] as int);
  }
}
