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
            GestureDetector(
              // automatically triggers a rebuild of the Counter widget
              onTap: () => counter.value++,
              child: Text(
                counter.value.toString(),
                style: const TextStyle(fontSize: 40),
              ),
            ),
            const Text(
              'Click the number to increase it\'s value',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
