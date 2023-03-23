import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseEffectPage extends HookWidget {
  const UseEffectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final numberNotifier = useState(0);
    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          numberNotifier.value = timer.tick;
        });

        // This will cancel the subscription when the widget is disposed
        // or if the callback is called again.
        return timer.cancel;
      },
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('useEffect Example'),
      ),
      body: Center(
        child: Text(
          'Timer number is ${numberNotifier.value}.',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
