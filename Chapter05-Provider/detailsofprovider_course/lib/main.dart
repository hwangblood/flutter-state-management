import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const String appName = 'Provider Details Example';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ObjectProvider(),
      child: const MyApp(),
    ),
  );
}

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

  ObjectProvider()
      : id = const Uuid().v4(),
        _cheapObject = CheapObject(),
        _expensiveObject = ExpensiveObject();

  /// Whenever call notifyListeners(), 'id' property will be reset
  @override
  void notifyListeners() {
    id = const Uuid().v4();
    super.notifyListeners();
  }

  void start() {
    _cheapObjStreamSubs = Stream.periodic(
      const Duration(seconds: 1),
    ).listen((_) {
      _cheapObject = CheapObject();
      notifyListeners();
    });

    _expensiveObjStreamSubs = Stream.periodic(
      const Duration(seconds: 2),
    ).listen((_) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
    });
  }

  void stop() {
    _cheapObjStreamSubs.cancel();
    _expensiveObjStreamSubs.cancel();
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
        title: const Text(appName),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Expanded(child: CheapWidget()),
              Expanded(child: ExpensiveWidget()),
            ],
          ),
          Row(
            children: const [
              Expanded(child: ObejctProviderWidget()),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<ObjectProvider>().start();
                },
                child: const Text('Start'),
              ),
              TextButton(
                onPressed: () {
                  context.read<ObjectProvider>().stop();
                },
                child: const Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheapWidget extends StatelessWidget {
  const CheapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CheapObject cheapObject = context.select<ObjectProvider, CheapObject>(
      (provider) => provider.cheapObject,
    );
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Column(
        children: [
          const Text('Cheap Widget'),
          const Text('Last updated'),
          Text(cheapObject.lastUpdated),
        ],
      ),
    );
  }
}

class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensiveObject expensiveObject =
        context.select<ObjectProvider, ExpensiveObject>(
      (provider) => provider.expensiveObject,
    );
    return Container(
      height: 100,
      color: Colors.green,
      child: Column(
        children: [
          const Text('Expensive Widget'),
          const Text('Last updated'),
          Text(expensiveObject.lastUpdated),
        ],
      ),
    );
  }
}

class ObejctProviderWidget extends StatelessWidget {
  const ObejctProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ObjectProvider>();
    return Container(
      height: 100,
      color: Colors.purple,
      child: Column(
        children: [
          const Text('Object Provider Widget'),
          const Text('ID'),
          Text(provider.id),
        ],
      ),
    );
  }
}
