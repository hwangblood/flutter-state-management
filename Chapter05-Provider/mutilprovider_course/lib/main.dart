// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(
          value: Stream<Seconds>.periodic(
            const Duration(seconds: 1),
            (_) => Seconds(),
          ),
          initialData: Seconds(),
        ),
        StreamProvider.value(
          value: Stream<Minuetes>.periodic(
            const Duration(seconds: 5),
            (_) => Minuetes(),
          ),
          initialData: Minuetes(),
        ),
      ],
      child: const MainApp(),
    ),
  );
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

String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

@immutable
class Minuetes {
  final String value;
  Minuetes() : value = now();
}

Stream<String> newStream(Duration duration) => Stream.periodic(
      const Duration(seconds: 1),
      (_) => now(),
    );

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Expanded(
      child: Container(
        color: Colors.yellow,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Seconds Widget'),
            Text(seconds.value),
          ],
        ),
      ),
    );
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minuetes>();
    return Expanded(
      child: Container(
        color: Colors.green,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Minutes Widget'),
            Text(minutes.value),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MultiProvider Example'),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              SecondsWidget(),
              MinutesWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
