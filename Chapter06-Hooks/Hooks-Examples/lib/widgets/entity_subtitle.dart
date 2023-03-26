import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/routes.dart';

class EntitySubtitle extends StatelessWidget {
  const EntitySubtitle({
    super.key,
    required this.routeEntity,
  });

  final BaseEntity routeEntity;

  @override
  Widget build(BuildContext context) {
    return Text(
      routeEntity.subtitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
