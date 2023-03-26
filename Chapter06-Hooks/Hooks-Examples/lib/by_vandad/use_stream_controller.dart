import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imgUrl = 'https://images6.alphacoders.com/126/thumbbig-1267998.webp';

class UseStreamController extends HookWidget {
  const UseStreamController({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;

    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      },
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('useStreamController'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
                stream: controller.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    final rotation = snapshot.data ?? 0.0;
                    return GestureDetector(
                      onTap: () {
                        controller.sink.add(rotation + 10.0);
                      },
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(rotation / 360.0),
                        child: Image.network(imgUrl),
                      ),
                    );
                  }
                }),
            const SizedBox(height: 16),
            const Text('Show a image and rotate it on every tap.'),
          ],
        ),
      ),
    );
  }
}
