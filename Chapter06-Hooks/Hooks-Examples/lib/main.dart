import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/examples/use_stream.dart';

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

class PageRouteEntity {
  final String title;
  final String subtitle;
  final Widget page;
  PageRouteEntity({
    required this.title,
    required this.subtitle,
    required this.page,
  });
}

final pages = [
  PageRouteEntity(
    title: 'useStream Example',
    subtitle: 'Change time per seconds with useStream Hook.',
    page: const UseStreamPage(),
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Hooks Examples'),
      ),
      body: ListView.separated(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final routeEntity = pages[index];
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

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => widget),
  );
}
