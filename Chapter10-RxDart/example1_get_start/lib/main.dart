import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

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

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // create ouor behavior subject1 every time widget is re-built
    final subject = useMemoized(
      () => BehaviorSubject<String>(),
      [key],
    );

    // dispose of the old subject every time widget is re-built
    useEffect(
      () => subject.close,
      [subject],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('1st Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: subject.sink.add,
            ),
            const SizedBox(height: 16),
            StreamBuilder(
              initialData: 'Please start typing...',
              stream: subject.stream.distinct().debounceTime(
                    const Duration(seconds: 1),
                  ),
              builder: (context, snapshot) {
                final text = snapshot.requireData;
                return Text(text.isNotEmpty ? text : 'Empty String');
              },
            ),
          ],
        ),
      ),
    );
  }
}
