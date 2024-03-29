import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const String appName = 'Provider Example - Breadcrumb';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BreadCrumbProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/new': (context) => const NewBreadCrumbPage(),
      },
    );
  }
}

class BreadCrumb {
  bool isActive;
  final String uuid;
  final String name;
  BreadCrumb({
    required this.isActive,
    required this.name,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];

  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (var item in _items) {
      item.isActive = true;
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumbsWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  const BreadCrumbsWidget({
    Key? key,
    required this.breadCrumbs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(8.0),
      color: const Color.fromARGB(255, 255, 255, 50),
      child: breadCrumbs.isNotEmpty
          ? Wrap(
              children: breadCrumbs.map((breadCrumb) {
                return Text(
                  breadCrumb.title,
                  style: TextStyle(
                    color: breadCrumb.isActive ? Colors.blue : Colors.black,
                  ),
                );
              }).toList(),
            )
          : const Center(
              child: Text('No bread crumbs now.'),
            ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (context, provider, child) {
              return BreadCrumbsWidget(breadCrumbs: provider.items);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/new');
                },
                child: const Text('New bread crumb'),
              ),
              OutlinedButton(
                onPressed: () {
                  context.read<BreadCrumbProvider>().reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewBreadCrumbPage extends StatefulWidget {
  const NewBreadCrumbPage({super.key});

  @override
  State<NewBreadCrumbPage> createState() => _NewBreadCrumbPageState();
}

class _NewBreadCrumbPageState extends State<NewBreadCrumbPage> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New bread crumb'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Name for Bread Crumb',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text;
                if (text.isNotEmpty) {
                  final breadCrumb = BreadCrumb(isActive: false, name: text);
                  context.read<BreadCrumbProvider>().add(breadCrumb);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
