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

final primitivesEntities = [
  ExampleRouteEntity(
    title: 'useState Example',
    subtitle: 'Creates a variable and subscribes to it.',
    page: const UseStatePage(),
  ),
  ExampleRouteEntity(
    title: 'useEffect Example',
    subtitle: 'Useful for side-effects and optionally canceling them.',
    page: const UseEffectPage(),
  ),
  ExampleRouteEntity(
    title: 'useStream Example',
    subtitle: 'Change time per seconds with useStream Hook.',
    page: const UseStreamPage(),
  ),
];

final miscEntities = [
  ExampleRouteEntity(
    title: 'useTextEditingController Example',
    subtitle: 'useTextEditingController work with useState and useEffect.',
    page: const UseTextEditingControllerPage(),
  ),
];
