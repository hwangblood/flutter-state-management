import 'package:flutter/material.dart';

import 'package:testingflutterhooks_course/examples/examples.dart';
import 'package:testingflutterhooks_course/by_vandad/by_vandad.dart';
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

final categoryEntities = <BaseEntity>[
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
  RouteEntity(
    title: 'Examples by Vandad',
    subtitle: 'Eight examples created by Vandad',
    page: EntityPage(
      title: 'Examples from Vandad',
      entities: entitiesByVandad,
    ),
  ),
];

final objectBindingEntities = <RouteEntity>[
  RouteEntity(
    title: 'dart:async related hooks',
    subtitle: 'subtitle of dart:async related hooks',
    page: EntityPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  RouteEntity(
    title: 'Animation related hooks',
    subtitle: 'subtitle of Animation related hooks',
    page: EntityPage(
      title: 'Animation related hooks',
      entities: [],
    ),
  ),
  RouteEntity(
    title: 'Listenable related hooks',
    subtitle: 'subtitle of Listenable related hooks',
    page: EntityPage(
      title: 'Listenable related hooks',
      entities: listenableRelatedEntities,
    ),
  ),
];

final primitivesEntities = <RouteEntity>[
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

final asyncRelatedEntities = <RouteEntity>[];

final listenableRelatedEntities = <RouteEntity>[];

final miscEntities = <RouteEntity>[];

final entitiesByVandad = <RouteEntity>[
  RouteEntity(
    title: 'useStream Example',
    subtitle:
        'Subscribes to a Stream and returns its current state as an AsyncSnapshot.',
    page: const UseStream(),
  ),
  RouteEntity(
    title: 'useTextEditingController & useState',
    subtitle: 'useTextEditingController change a value of useState.',
    page: const UseTextEditingControllerAndState(),
  ),
  RouteEntity(
    title: 'useFuture & useMemorized',
    subtitle:
        'Caching a Future<Widget> with useMemorized, and show it with useFuture.',
    page: const UseFutureAndMemorized(),
  ),
  RouteEntity(
    title: 'useListenable & useMemorized',
    subtitle:
        'Subscribes to a Listenable and marks the widget as needing build whenever the listener is called.',
    page: const UseListenableAndMemorized(),
  ),
  RouteEntity(
    title: 'useAnimationController & useScrollController',
    subtitle: 'useAnimationController works with useScrollController.',
    page: const UseScrollControllerAndAnimationController(),
  ),
  RouteEntity(
    title: 'useStreamScrollController',
    subtitle: 'Show a image and rotate it on every tap.',
    page: const UseStreamController(),
  ),
];
