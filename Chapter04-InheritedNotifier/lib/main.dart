import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomPage(),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    super.key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          notifier: sliderData,
          child: child,
        );

  static double of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()!
      .notifier!
      .value;
}

class HomPage extends StatelessWidget {
  const HomPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifier & InheritedNotifier Demo'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider(
                value: SliderInheritedNotifier.of(context),
                onChanged: (double value) {
                  sliderData.value = value;
                },
              ),
              Row(
                children: [
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      color: Colors.yellow,
                      height: 200,
                    ),
                  ),
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      color: Colors.blue,
                      height: 200,
                    ),
                  ),
                ].expandequally().toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandequally() => map(
        (e) => Expanded(child: e),
      );
}
