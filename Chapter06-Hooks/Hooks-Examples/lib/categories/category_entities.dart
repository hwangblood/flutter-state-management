import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/categories/categories.dart';
import 'package:testingflutterhooks_course/categories/misc_category_page.dart';

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

final category_entities = [
  CategoryRouteEntity(
    title: 'Primitives hooks',
    subtitle:
        'A set of low-level hooks that interact with the different life-cycles of a widget',
    page: const PrimitivesCategoryPage(),
  ),
  CategoryRouteEntity(
    title: 'dart:async related hooks',
    subtitle: '...',
    page: Container(),
  ),
  CategoryRouteEntity(
    title: 'Misc hooks',
    subtitle: 'A series of hooks with no particular theme.',
    page: const MiscCategoryPage(),
  ),
];
