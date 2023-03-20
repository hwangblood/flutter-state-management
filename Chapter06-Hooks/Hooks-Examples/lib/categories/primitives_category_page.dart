import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/examples/examples_entities.dart';
import 'package:testingflutterhooks_course/navigete_to.dart';

class PrimitivesCategoryPage extends StatelessWidget {
  const PrimitivesCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Primitives Hooks'),
      ),
      body: ListView.separated(
        itemCount: primitivesEntities.length,
        itemBuilder: (context, index) {
          final routeEntity = primitivesEntities[index];
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
