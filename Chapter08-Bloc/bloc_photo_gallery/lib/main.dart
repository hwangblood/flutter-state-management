import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
