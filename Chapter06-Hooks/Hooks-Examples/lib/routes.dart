import 'package:flutter/material.dart';

import 'package:testingflutterhooks_course/examples/examples.dart';
import 'package:testingflutterhooks_course/pages/pages.dart';

class BaseEntity {
  final String title;
  final String subtitle;
  BaseEntity({
    required this.title,
    required this.subtitle,
  });
}

class RouteEntity extends BaseEntity {
  final Widget page;

  @override
  RouteEntity({
    required String title,
    required String subtitle,
    required this.page,
  }) : super(title: title, subtitle: subtitle);
}

class ExpansionEntity extends BaseEntity {
  final List<RouteEntity> entities;

  ExpansionEntity({
    required String title,
    required String subtitle,
    required this.entities,
  }) : super(title: title, subtitle: subtitle);
}

final categoryEntities = [
  RouteEntity(
    title: 'Primitives hooks',
    subtitle:
        'A set of low-level hooks that interact with the different life-cycles of a widget',
    page: EntityPage(
      title: 'Primitives hooks',
      entities: primitivesEntities,
    ),
  ),
  ExpansionEntity(
    title: 'Object-binding',
    subtitle:
        'This category of hooks the manipulation of existing Flutter/Dart objects with hooks. They will take care of creating/updating/disposing an object.',
    entities: objectBindingEntities,
  ),
  RouteEntity(
    title: 'Misc hooks',
    subtitle: 'A series of hooks with no particular theme.',
    page: EntityPage(
      title: 'Misc hooks',
      entities: miscEntities,
    ),
  ),
];

final objectBindingEntities = [
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: 'subtitle of dart:async related hooks',
    page: EntityPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: 'subtitle of dart:async related hooks',
    page: EntityPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: 'subtitle of dart:async related hooks',
    page: EntityPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: 'subtitle of dart:async related hooks',
    page: EntityPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
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
    title: 'useMemoized Example',
    subtitle: '	Caches the instance of a complex object.',
    page: const UseMemoizedPage(),
  ),
];

final asyncRelatedEntities = [
  RouteEntity(
    title: 'useStream Example',
    subtitle:
        'Subscribes to a Stream and returns its current state as an AsyncSnapshot.',
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
