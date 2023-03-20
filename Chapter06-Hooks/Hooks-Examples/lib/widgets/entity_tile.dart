import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/navigete_to.dart';
import 'package:testingflutterhooks_course/routes.dart';
import 'package:testingflutterhooks_course/widgets/entity_subtitle.dart';

class RouteEntityTile extends StatelessWidget {
  const RouteEntityTile({
    super.key,
    required this.routeEntity,
  });

  final RouteEntity routeEntity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(routeEntity.title),
      subtitle: EntitySubtitle(routeEntity: routeEntity),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => navigateTo(context, routeEntity.page),
    );
  }
}
