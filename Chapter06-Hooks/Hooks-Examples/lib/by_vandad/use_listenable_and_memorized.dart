import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  final int from;

  CountDown({required this.from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((value) {
      this.value = value;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class UseListenableAndMemorized extends HookWidget {
  const UseListenableAndMemorized({super.key});

  @override
  Widget build(BuildContext context) {
    // Caching the CountDown object, it doesn't call build function again
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('useListenable & useMemoized'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CountDown value is ${notifier.value}.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Text('count down from 20 to 0 and stop.')
          ],
        ),
      ),
    );
  }
}
