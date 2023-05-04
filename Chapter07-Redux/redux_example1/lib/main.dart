import 'package:flutter/material.dart';

const String appName = 'Redux Example1';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appName,
      home: HomePage(),
    );
  }
}

enum ItemFilter { all, longTexts, shortTexts }

@immutable
class State {
  final Iterable<String> items;
  final ItemFilter itemFilter;

  const State({
    required this.items,
    required this.itemFilter,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
