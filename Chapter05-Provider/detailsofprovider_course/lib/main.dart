import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

@immutable
class BaseObject {
  final String id;
  final String lastUpdated;
  BaseObject()
      : id = const Uuid().v4(),
        lastUpdated = DateTime.now().toIso8601String();

  @override
  bool operator ==(covariant BaseObject other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@immutable
class ExpensiveObject extends BaseObject {}

@immutable
class CheapObject extends BaseObject {}

class ObjectProvider extends ChangeNotifier {
  late String id;

  late CheapObject _cheapObject;
  late StreamSubscription _cheapObjStreamSubs;

  late ExpensiveObject _expensiveObject;
  late StreamSubscription _expensiveObjStreamSubs;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  void start() {
    _cheapObjStreamSubs = Stream.periodic(
      const Duration(seconds: 1),
    ).listen((_) {
      _cheapObject = CheapObject();
    });

    _expensiveObjStreamSubs = Stream.periodic(
      const Duration(seconds: 1),
    ).listen((_) {
      _expensiveObject = ExpensiveObject();
    });

    notifyListeners();
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
        title: const Text('Provider Details Example'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
