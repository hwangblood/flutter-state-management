import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

const exampleName = 'Provider Example';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: exampleName,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final datetimeProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datetime = ref.watch(datetimeProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(exampleName),
      ),
      body: Center(
        child: Text(
          'Current: ${datetime.toString()}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
