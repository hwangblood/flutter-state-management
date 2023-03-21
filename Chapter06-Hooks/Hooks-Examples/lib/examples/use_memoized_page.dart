import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseMemoizedPage extends HookWidget {
  const UseMemoizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = useMemoized<Stream<int>>(
      () => Stream.periodic(const Duration(seconds: 1), (i) => i + 1),
      // keys argument for useMemoized are similar to useEffect
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('useMemoized Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('useMemoized<Stream<int>>(() => stream, [ ]);'),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: stream,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text(
                  'The number from stream is ${snapshot.data ?? 0}.',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
