import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/routes.dart';
import 'package:testingflutterhooks_course/widgets/widgets.dart';

class EntityPage extends StatelessWidget {
  final String title;
  final List<RouteEntity> entities;
  const EntityPage({
    super.key,
    required this.title,
    required this.entities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: EntityList(
        isPrimary: true,
        entities: entities,
      ),
    );
  }
}
