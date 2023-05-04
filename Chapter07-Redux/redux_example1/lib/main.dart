import 'package:flutter/material.dart';

const String appName = 'Redux Example1';

void main() => runApp(const MyApp());

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

enum ItemFilter { all, longTexts, shortTexts }

@immutable
class State {
  final Iterable<String> items;
  final ItemFilter itemFilter;

  const State({
    required this.items,
    required this.itemFilter,
  });

  Iterable<String> get filteredItems {
    switch (itemFilter) {
      case ItemFilter.all:
        return items;
      case ItemFilter.longTexts:
        return items.where((element) => element.length > 10);
      case ItemFilter.shortTexts:
        return items.where((element) => element.length <= 5);
    }
  }
}

@immutable
abstract class Action {
  const Action();
}

@immutable
class ChangeFilterTypeAction extends Action {
  final ItemFilter filter;

  const ChangeFilterTypeAction(this.filter);
}

@immutable
abstract class ItemAction {
  final String item;
  const ItemAction(this.item);
}

@immutable
class AddItemAction extends ItemAction {
  const AddItemAction(super.item);
}

@immutable
class RemoveItemAction extends ItemAction {
  const RemoveItemAction(super.item);
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
