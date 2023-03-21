import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseStatePage extends HookWidget {
  const UseStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('useState Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              counter.value.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            const Text(
              'Click Button to increase the number',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // automatically triggers a rebuild of the UseStatePage widget
        onPressed: () => counter.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
