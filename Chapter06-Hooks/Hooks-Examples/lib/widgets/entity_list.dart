import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/routes.dart';
import 'package:testingflutterhooks_course/widgets/entity_tile.dart';

class EntityList extends StatelessWidget {
  final bool isPrimary;
  final List<RouteEntity> entities;
  const EntityList({super.key, required this.entities, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: isPrimary,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final routeEntity = entities.elementAt(index);
        return RouteEntityTile(routeEntity: routeEntity);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: entities.length,
    );
  }
}

List<Widget> generateEntityList(List<RouteEntity> entities) {
  return List.generate(entities.length, (index) {
    final routeEntity = entities.elementAt(index);
    return RouteEntityTile(routeEntity: routeEntity);
  });
}
