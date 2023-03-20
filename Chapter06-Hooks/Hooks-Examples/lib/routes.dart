import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/category_page.dart';
import 'package:testingflutterhooks_course/examples/examples.dart';

class RouteEntity {
  final String title;
  final String subtitle;
  final Widget page;
  RouteEntity({
    required this.title,
    required this.subtitle,
    required this.page,
  });
}

final categoryEntities = [
  RouteEntity(
    title: 'Primitives hooks',
    subtitle:
        'A set of low-level hooks that interact with the different life-cycles of a widget',
    page: CategoryPage(
      title: 'Primitives hooks',
      entities: primitivesEntities,
    ),
  ),
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: '...',
    page: CategoryPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  RouteEntity(
    title: 'Misc hooks',
    subtitle: 'A series of hooks with no particular theme.',
    page: CategoryPage(
      title: 'Misc hooks',
      entities: miscEntities,
    ),
  ),
];

final primitivesEntities = [
  RouteEntity(
    title: 'useState Example',
    subtitle: 'Creates a variable and subscribes to it.',
    page: const UseStatePage(),
  ),
  RouteEntity(
    title: 'useEffect Example',
    subtitle: 'Useful for side-effects and optionally canceling them.',
    page: const UseEffectPage(),
  ),
  RouteEntity(
    title: 'useStream Example',
    subtitle: 'Change time per seconds with useStream Hook.',
    page: const UseStreamPage(),
  ),
];

final asyncRelatedEntities = [
  RouteEntity(
    title: 'useStream Example',
    subtitle: 'Change time per seconds with useStream Hook.',
    page: const UseStreamPage(),
  ),
];

final miscEntities = [
  RouteEntity(
    title: 'useTextEditingController Example',
    subtitle: 'useTextEditingController work with useState and useEffect.',
    page: const UseTextEditingControllerPage(),
  ),
];
