import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() => runApp(const MyApp());

void testZip() async {
  final streamA = Stream.periodic(
    const Duration(seconds: 1),
    (count) => 'A-$count',
  );
  final streamB = Stream.periodic(
    const Duration(seconds: 3),
    (count) => 'B-$count',
  ).take(3);

  final result = Rx.zip2(
    streamA,
    streamB,
    (a, b) => 'zipped: ${[a, b]}',
  );

  await for (var value in result) {
    value.log();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    testZip();
    return const MaterialApp(
      title: 'RxDart Course',
      home: HomePage(),
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
        title: const Text('zip() Example'),
      ),
      body: const Center(
        child: Text('Open your debug console to see how zip() works.'),
      ),
    );
  }
}
