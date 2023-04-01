import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() => runApp(const MyApp());

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

void testCombineLatest() async {
  final stream1 = Stream.periodic(
      const Duration(seconds: 1), (count) => 'Stream 1, count = $count');
  final stream2 = Stream.periodic(
      const Duration(seconds: 3), (count) => 'Stream 2, count = $count');

  final combinedStream = Rx.combineLatest2(
    stream1,
    stream2,
    (a, b) => 'One = ($a), Two = ($b)',
  );

  await for (var value in combinedStream) {
    value.log();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    testCombineLatest();
    return Scaffold(
      appBar: AppBar(
        title: const Text('combineLatest Example'),
      ),
      body: Center(
        child: Text(
          'Open your debug console in VS Code\n\nAnd see how combineLatest works.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
