import 'package:example7_switch_map/datetime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RxDart Course',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final BehaviorSubject<DateTime> subject;
  late final Stream<String> streamOfStrings;
  @override
  void initState() {
    super.initState();
    subject = BehaviorSubject<DateTime>();
    // When a new value added to subject, this stream will be re-assign
    streamOfStrings = subject.switchMap(
      (dateTime) => Stream.periodic(
        const Duration(seconds: 1),
        (count) => 'count: $count\ndateTime: '
            '${DateTimeFormatter.simplyFormat(dateTime: dateTime)}',
      ),
    );
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('switchMap() Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            StreamBuilder<String>(
              stream: streamOfStrings,
              builder: (context, snapshot) {
                final textStyle = Theme.of(context).textTheme.bodyLarge;
                if (snapshot.hasData) {
                  final string = snapshot.requireData;
                  return Text(string, style: textStyle);
                }
                return Text(
                  'Press the Button to start',
                  style: textStyle,
                );
              },
            ),
            OutlinedButton(
              onPressed: () {
                subject.add(DateTime.now());
              },
              child: const Text('Re-start the stream'),
            ),
            const Text(
              'Every press of the button will recreate/restart the result '
              'stream',
            ),
          ],
        ),
      ),
    );
  }
}
