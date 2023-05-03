import 'dart:developer' as devtools show log;
import 'dart:math';

import 'package:flutter/material.dart';

const String appName = 'InheritedModel Example';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appName,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _color1 = Colors.yellow;
  var _color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: AvailableColorsWidget(
        color1: _color1,
        color2: _color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color 1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change Color 2'),
                ),
              ],
            ),
            const ColorWidget(colorAspect: AvailableColors.one),
            const ColorWidget(colorAspect: AvailableColors.two),
          ],
        ),
      ),
    );
  }
}

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;
  const AvailableColorsWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(key: key, child: child);

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log('updateShouldNotify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    devtools.log('updateShouldNotifyDependent');
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors colorAspect;
  const ColorWidget({super.key, required this.colorAspect});

  @override
  Widget build(BuildContext context) {
    switch (colorAspect) {
      case AvailableColors.one:
        devtools.log('Color one widget got rebuilt.');
        break;
      case AvailableColors.two:
        devtools.log('Color two widget got rebuilt.');
        break;
    }
    final provider = AvailableColorsWidget.of(context, colorAspect);
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: double.infinity,
      color: colorAspect == AvailableColors.one
          ? provider.color1
          : provider.color2,
      child: Text(
        colorAspect == AvailableColors.one ? 'Color 1' : 'Color 2',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

final colors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.brown,
  Colors.amber,
  Colors.deepPurple
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}
