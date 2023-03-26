import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Stream<String> datetimeStream = Stream.periodic(
  const Duration(seconds: 1),
  (_) => DateTime.now().toLocal().toString(),
);

class UseStream extends HookWidget {
  const UseStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final datetime = useStream(datetimeStream);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('useStream Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('useStream change the appbar title per second'),
            Text(datetime.data ?? 'useStream Example'),
            ErrorWidget(Exception(
                'If you leave this page, the Stream is still listened.')),
          ],
        ),
      ),
    );
  }
}
