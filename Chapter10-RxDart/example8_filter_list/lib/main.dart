// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

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

enum TypeOfThing { person, animal }

@immutable
class Thing {
  final String name;
  final TypeOfThing type;
  const Thing({
    required this.name,
    required this.type,
  });
}

@immutable
class ThingsBloc {
  final Sink<TypeOfThing?> typeOfThingSink; // write-only
  final Stream<TypeOfThing?> typeOfThing; // read-only
  final Stream<Iterable<Thing>> things; // read-only

  const ThingsBloc._({
    required this.typeOfThingSink,
    required this.typeOfThing,
    required this.things,
  });

  factory ThingsBloc({
    required Iterable<Thing> things,
  }) {
    final typeOfThingSubject = BehaviorSubject<TypeOfThing?>();
    final filteredThings =
        typeOfThingSubject.debounceTime(const Duration(milliseconds: 300)).map(
      (typeOfThing) {
        if (typeOfThing != null) {
          return things.where((thing) => thing.type == typeOfThing);
        } else {
          return things;
        }
      },
    ).startWith(things);

    return ThingsBloc._(
      typeOfThingSink: typeOfThingSubject.sink,
      typeOfThing: typeOfThingSubject.stream,
      things: filteredThings,
    );
  }

  void dispose() {
    typeOfThingSink.close();
  }
}

const allThings = [
  // persons
  Thing(name: 'Foo', type: TypeOfThing.person),
  Thing(name: 'Bar', type: TypeOfThing.person),
  Thing(name: 'Baz', type: TypeOfThing.person),
  // animals
  Thing(name: 'Bunz', type: TypeOfThing.animal),
  Thing(name: 'Kitty', type: TypeOfThing.animal),
  Thing(name: 'Woofz', type: TypeOfThing.animal),
];

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ThingsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = ThingsBloc(things: allThings);
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
        title: const Text('Filter List with RxDart'),
      ),
      body: Column(
        children: [
          StreamBuilder<TypeOfThing?>(
            stream: bloc.typeOfThing,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong.'),
                );
              }

              final selectedTypeOfThing = snapshot.data;
              return Wrap(
                children: TypeOfThing.values.map((typeOfThing) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      selectedColor: Colors.blue.shade100,
                      label: Text(typeOfThing.name),
                      onSelected: (isSelected) {
                        final type = isSelected ? typeOfThing : null;
                        bloc.typeOfThingSink.add(type);
                      },
                      selected: selectedTypeOfThing == typeOfThing,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<Iterable<Thing>>(
              stream: bloc.things,
              builder: (context, snapshot) {
                final things = snapshot.data ?? [];
                return ListView.separated(
                  itemCount: things.length,
                  itemBuilder: (context, index) {
                    final thing = things.elementAt(index);
                    return ListTile(
                      title: Text(thing.name),
                      subtitle: Text(thing.type.name),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
