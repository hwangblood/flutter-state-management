import 'package:flutter/material.dart';
import 'package:testingrxdart_course/examples/examples.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RxDart Course',
      home: HomePage(),
    );
  }
}

final pages = [
  const Example1(),
];

void navigateTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RxDart Course'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final page = pages.elementAt(index);
          return ListTile(
            title: Text('item $index'),
            onTap: () => navigateTo(context, page),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: pages.length,
      ),
    );
  }
}
