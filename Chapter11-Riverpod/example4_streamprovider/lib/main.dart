import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

/// 10 names
const names = [
  'Patty O’Furniture',
  'Olive Yew',
  'Aida Bugg',
  'Maureen Biologist',
  'Teri Dactyl',
  'Peg Legge',
  'Allie Grater',
  'Liz Erd',
  'A. Mused',
  'Constance Noring',
];

final tickerProvider = StreamProvider<int>((ref) {
  // Stream<int> start with int 1
  return Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) => computationCount + 1,
  );
});

final namesProvider = StreamProvider((ref) {
  return ref.watch(tickerProvider.stream).map(
        // ! when count > names.length, will throw an error
        (count) => names.getRange(0, count),
      );
});

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamProvider Example'),
      ),
      body: names.when(
        data: (data) {
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text('${index + 1}: ${data.elementAt(index)}'),
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: data.length,
          );
        },
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
