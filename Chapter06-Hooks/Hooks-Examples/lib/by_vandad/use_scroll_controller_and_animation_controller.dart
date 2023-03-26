import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imageUrl = 'https://images5.alphacoders.com/130/thumbbig-1304215.webp';
const imageHeight = 300.0;

const listLength = 100;

extension Normalize on num {
  num normalize(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
          ((this - normalizedRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}

class UseScrollControllerAndAnimationController extends HookWidget {
  const UseScrollControllerAndAnimationController({super.key});

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalize(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });

      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('useScrollController & useAnimationController'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                imageUrl,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: controller,
              children: [
                const ListTile(
                  title: Text(
                      'Display a scrollable list under an image (hide, scale the image upon scroll)'),
                ),
                ...List.generate(
                  listLength,
                  (index) => Column(
                    children: [
                      if (index <= listLength) const Divider(),
                      ListTile(
                        title: Text('Item $index'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
