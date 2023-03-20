import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/examples/examples_entities.dart';
import 'package:testingflutterhooks_course/navigete_to.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final List<ExampleRouteEntity> entities;
  const CategoryPage({
    super.key,
    required this.title,
    required this.entities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Misc Hooks'),
      ),
      body: ListView.separated(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          final routeEntity = entities[index];
          return ListTile(
            title: Text(routeEntity.title),
            subtitle: Text(routeEntity.subtitle),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => navigateTo(context, routeEntity.page),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
