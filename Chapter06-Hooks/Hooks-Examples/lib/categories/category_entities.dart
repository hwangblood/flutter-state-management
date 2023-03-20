import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/categories/categories.dart';
import 'package:testingflutterhooks_course/examples/examples.dart';

class CategoryRouteEntity {
  final String title;
  final String subtitle;
  final Widget page;
  CategoryRouteEntity({
    required this.title,
    required this.subtitle,
    required this.page,
  });
}

final categoryEntities = [
  CategoryRouteEntity(
    title: 'Primitives hooks',
    subtitle:
        'A set of low-level hooks that interact with the different life-cycles of a widget',
    page: CategoryPage(
      title: 'Primitives hooks',
      entities: primitivesEntities,
    ),
  ),
  CategoryRouteEntity(
    title: 'dart:async related hooks',
    subtitle: '...',
    page: CategoryPage(
      title: 'dart:async related hooks',
      entities: asyncRelatedEntities,
    ),
  ),
  CategoryRouteEntity(
    title: 'Misc hooks',
    subtitle: 'A series of hooks with no particular theme.',
    page: CategoryPage(
      title: 'Misc hooks',
      entities: miscEntities,
    ),
  ),
];
