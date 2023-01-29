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

class HomPage extends StatelessWidget {
  const HomPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Slider(
            value: 0,
            onChanged: (double value) {},
          ),
          Row(
            children: [
              Container(
                color: Colors.yellow,
                height: 200,
              ),
              Container(
                color: Colors.blue,
                height: 200,
              ),
            ].expandequally().toList(),
          ),
        ],
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandequally() => map(
        (e) => Expanded(child: e),
      );
}
