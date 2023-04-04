import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

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

Stream<String> getNames({
  required String filePath,
}) {
  final namesFuture = rootBundle.loadString(filePath);
  final result = Stream.fromFuture(namesFuture).transform(const LineSplitter());
  return result;
}

const catsFilePath = 'assets/texts/cats.txt';
const dogsFilePath = 'assets/texts/dogs.txt';

Stream<String> catsNameStream = getNames(
  filePath: catsFilePath,
).map(
  (value) => 'Cat - $value',
);

Stream<String> dogsNameStream = getNames(
  filePath: catsFilePath,
).map(
  (value) => 'Dog - $value',
);

Stream<String> result = catsNameStream.concatWith(
  [dogsNameStream],
);

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animal List with RxDart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Cats and Dogs are from different Streams.'),
                const SizedBox(height: 8.0),
                Text(
                  'Stream will not be disposed.',
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          // Stream has already been listened to.
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder(
              future: result.toList(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final names = snapshot.requireData;
                    return ListView.separated(
                      itemCount: names.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(names.elementAt(index)),
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
