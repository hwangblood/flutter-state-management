import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() => runApp(const MyApp());

void testMerge() async {
  final stream1 = Stream.periodic(
    const Duration(seconds: 1),
    (count) => 'Stream 1, count = $count',
  );
  final stream2 = Stream.periodic(
    const Duration(seconds: 3),
    (count) => 'Stream 2, count = $count',
  );

  // final result = stream1.mergeWith([stream2]);

  final result = Rx.merge([stream1, stream2]);

  await for (var value in result) {
    value.log();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    testMerge();
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
        title: const Text('merge() Example'),
      ),
      body: const Center(
        child: Text('Open your debug console to see how merge() works.'),
      ),
    );
  }
}
