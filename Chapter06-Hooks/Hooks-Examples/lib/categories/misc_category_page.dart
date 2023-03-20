import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/examples/examples_entities.dart';
import 'package:testingflutterhooks_course/navigete_to.dart';

class MiscCategoryPage extends StatelessWidget {
  const MiscCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Misc Hooks'),
      ),
      body: ListView.separated(
        itemCount: miscEntities.length,
        itemBuilder: (context, index) {
          final routeEntity = miscEntities[index];
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
