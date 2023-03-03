import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

Stream<String> getTime = Stream.periodic(
  const Duration(seconds: 1),
  (_) => DateTime.now().toLocal().toString(),
);

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final datetime = useStream(getTime);
    return Scaffold(
      appBar: AppBar(
        title: Text(datetime.data ?? 'Home Page'),
      ),
      body: const Center(
        child: Text('useStream change the appbar title per second'),
      ),
    );
  }
}
