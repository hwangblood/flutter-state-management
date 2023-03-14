import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/examples/examples.dart';

class ExampleRouteEntity {
  final String title;
  final String subtitle;
  final Widget page;
  ExampleRouteEntity({
    required this.title,
    required this.subtitle,
    required this.page,
  });
}

final primitives_entities = [
  ExampleRouteEntity(
    title: 'useStream Example',
    subtitle: 'Change time per seconds with useStream Hook.',
    page: const UseStreamPage(),
  ),
];

final misc_entities = [
  ExampleRouteEntity(
    title: 'useTextEditingController Example',
    subtitle: 'useTextEditingController work with useState and useEffect.',
    page: const UseTextEditingControllerPage(),
  ),
];
