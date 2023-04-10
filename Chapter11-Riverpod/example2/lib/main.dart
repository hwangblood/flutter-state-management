import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Riverpod Course',
      home: HomePage(),
    );
  }
}

extension OptionalInfixAddition<T extends num> on T? {
  /// when object is null, is can't access add + operator
  ///
  /// Example:
  ///
  /// final int? n = 1;
  ///
  /// final int? m = null;
  ///
  /// final result = n + m;  // It's ok, the result could be null
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class CounterNotifier extends StateNotifier<int?> {
  CounterNotifier() : super(null);

  void increase() {
    state = state == null ? 1 : state + 1;
  }

  int? get value => state;
}

final counterProvider = StateNotifierProvider<CounterNotifier, int?>(
  (ref) => CounterNotifier(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('StateNotifierProvider Example'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            // or
            // final count = ref.watch(counterProvider.notifier).value;
            final text =
                count == null ? 'Press the Button' : 'The value is $count';
            return Text(text);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(counterProvider.notifier).increase,
        child: const Tooltip(
          message: 'Increase',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
