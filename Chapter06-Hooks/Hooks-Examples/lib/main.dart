import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/routes.dart';
import 'package:testingflutterhooks_course/navigete_to.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Hooks Categories'),
      ),
      body: ListView.separated(
        itemCount: categoryEntities.length,
        itemBuilder: (context, index) {
          final routeEntity = categoryEntities[index];
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
