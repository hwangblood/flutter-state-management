// ignore_for_file: public_member_api_docs, sort_constructors_first
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

@immutable
class NameBloc {
  final Sink<String?> firstNameSink; // write-only
  final Sink<String?> lastNameSink; // write-only
  final Stream<String> fullNameStream; // read-only
  const NameBloc._({
    required this.firstNameSink,
    required this.lastNameSink,
    required this.fullNameStream,
  });

  factory NameBloc() {
    final firstNameSubject = BehaviorSubject<String?>();
    final lastNameSubject = BehaviorSubject<String?>();

    final Stream<String> fullNameStream = Rx.combineLatest2(
      firstNameSubject.startWith(null),
      lastNameSubject.startWith(null),
      (firstName, lastName) {
        if (firstName != null &&
            firstName.isNotEmpty &&
            lastName != null &&
            lastName.isNotEmpty) {
          return '$firstName $lastName';
        } else {
          return 'Both first and last name must be provided.';
        }
      },
    );

    return NameBloc._(
      firstNameSink: firstNameSubject.sink,
      lastNameSink: lastNameSubject.sink,
      fullNameStream: fullNameStream,
    );
  }

  void dispose() {
    firstNameSink.close();
    lastNameSink.close();
  }
}

typedef AsyncSnapshotBuilderCallback<T> = Widget Function(
  BuildContext context,
  T? value,
);

class AsyncSnapshotBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncSnapshotBuilderCallback<T>? onNone;
  final AsyncSnapshotBuilderCallback<T>? onWaiting;
  final AsyncSnapshotBuilderCallback<T>? onActive;
  final AsyncSnapshotBuilderCallback<T>? onDone;

  const AsyncSnapshotBuilder({
    Key? key,
    required this.stream,
    this.onNone,
    this.onWaiting,
    this.onActive,
    this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            final callback = onNone ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
          case ConnectionState.waiting:
            final callback =
                onWaiting ?? (_, __) => const CircularProgressIndicator();
            return callback(context, snapshot.data);
          case ConnectionState.active:
            final callback = onActive ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
          case ConnectionState.done:
            final callback = onDone ?? (_, __) => const SizedBox();
            return callback(context, snapshot.data);
        }
      },
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
  late final NameBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = NameBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Name Combiner with RxDart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your first name here...',
              ),
              onChanged: bloc.firstNameSink.add,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your last name here...',
              ),
              onChanged: bloc.lastNameSink.add,
            ),
            const SizedBox(height: 8),
            AsyncSnapshotBuilder<String>(
              stream: bloc.fullNameStream,
              onActive: (context, value) => Text(value ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
