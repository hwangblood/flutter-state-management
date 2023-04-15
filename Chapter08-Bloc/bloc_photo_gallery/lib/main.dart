import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Photo Gallery',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bloc Photo Gallery'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
