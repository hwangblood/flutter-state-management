import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const String appName = 'Redux Example1';

void main() {
  final store = Store<State>(
    appStateReducer,
    initialState: const State(items: [], filter: ItemFilter.all),
  );

  runApp(
    StoreProvider(
      store: store,
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

enum ItemFilter { all, longTexts, shortTexts }

@immutable
class State {
  final Iterable<String> items;
  final ItemFilter filter;

  const State({
    required this.items,
    required this.filter,
  });

  Iterable<String> get filteredItems {
    switch (filter) {
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
abstract class ItemAction extends Action {
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

extension AdddRemoveItems<T> on Iterable<T> {
  /// Add an item to a list
  Iterable<T> operator +(T other) => followedBy([other]);

  /// Remove items from a list
  Iterable<T> operator -(T other) => where((el) => el != other);
}

Iterable<String> addItemReducer(
  Iterable<String> previousItems,
  AddItemAction action,
) =>
    previousItems + action.item;

Iterable<String> removeItemReducer(
  Iterable<String> previousItems,
  RemoveItemAction action,
) =>
    previousItems - action.item;

Reducer<Iterable<String>> itemsReducer = combineReducers<Iterable<String>>([
  TypedReducer<Iterable<String>, AddItemAction>(addItemReducer),
  TypedReducer<Iterable<String>, RemoveItemAction>(removeItemReducer),
]);

ItemFilter itemFIlterReducer(State oldState, Action action) {
  if (action is ChangeFilterTypeAction) {
    return action.filter;
  } else {
    return oldState.filter;
  }
}

State appStateReducer(State oldState, action) => State(
      items: itemsReducer(oldState.items, action),
      filter: itemFIlterReducer(oldState, action),
    );

class HomePage extends hooks.HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textController = hooks.useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Column(
        children: [
          Row(
            children: [
              StoreConnector<State, VoidCallback>(
                converter: (Store<dynamic> store) {
                  return () => store.dispatch(
                        const ChangeFilterTypeAction(ItemFilter.all),
                      );
                },
                builder: (context, callback) {
                  return TextButton(
                    onPressed: callback,
                    child: const Text('All'),
                  );
                },
              ),
              StoreConnector<State, VoidCallback>(
                converter: (Store<dynamic> store) {
                  return () => store.dispatch(
                        const ChangeFilterTypeAction(ItemFilter.shortTexts),
                      );
                },
                builder: (context, callback) {
                  return TextButton(
                    onPressed: callback,
                    child: const Text('Short Items'),
                  );
                },
              ),
              StoreConnector<State, VoidCallback>(
                converter: (Store<dynamic> store) {
                  return () => store.dispatch(
                        const ChangeFilterTypeAction(ItemFilter.longTexts),
                      );
                },
                builder: (context, callback) {
                  return TextButton(
                    onPressed: callback,
                    child: const Text('Long Items'),
                  );
                },
              ),
            ],
          ),
          TextField(
            controller: textController,
          ),
          Row(
            children: [
              StoreConnector<State, VoidCallback>(
                converter: (Store<dynamic> store) {
                  final text = textController.text.trim();
                  return () => store.dispatch(
                        AddItemAction(text),
                      );
                },
                builder: (context, callback) {
                  return TextButton(
                    onPressed: () {
                      callback();
                      textController.clear();
                    },
                    child: const Text('Add'),
                  );
                },
              ),
              StoreConnector<State, VoidCallback>(
                converter: (Store<State> store) {
                  final text = textController.text.trim();
                  return () => store.dispatch(
                        RemoveItemAction(text),
                      );
                },
                builder: (context, callback) {
                  return TextButton(
                    onPressed: () {
                      callback();
                      textController.clear();
                    },
                    child: const Text('Remove'),
                  );
                },
              ),
            ],
          ),
          StoreConnector<State, Iterable<String>>(
            converter: (store) => store.state.filteredItems,
            builder: (context, items) {
              return Expanded(
                child: Column(
                  children: [
                    Text('items count: ${items.length}'),
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        itemBuilder: ((context, index) {
                          final item = items.elementAt(index);
                          return ListTile(
                            title: Text(item),
                          );
                        }),
                        separatorBuilder: (_, __) => const Divider(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
