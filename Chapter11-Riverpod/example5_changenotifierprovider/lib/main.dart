// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Course',
      theme: ThemeData.dark(useMaterial3: false),
      home: const HomePage(),
    );
  }
}

@immutable
class Person {
  final String uid;
  final String name;
  final int age;

  Person({
    String? uid,
    required this.name,
    required this.age,
  }) : uid = uid ?? const Uuid().v4();

  Person update(
    String? name,
    int? age,
  ) {
    return Person(
      uid: uid,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => this == other;

  @override
  int get hashCode => Object.hashAll([uid, name, age]);

  @override
  String toString() => 'Person(uid: $uid, name: $name, age: $age)';
}

class PeopleModel extends ChangeNotifier {
  final _people = <Person>[];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _people.indexWhere(
      (person) => person.uid == updatedPerson.uid,
    );
    final oldPerson = _people.elementAt(index);
    if (oldPerson != updatedPerson) {
      _people[index] = oldPerson.update(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

final ChangeNotifierProvider<PeopleModel> peopleProvider =
    ChangeNotifierProvider<PeopleModel>((ref) {
  return PeopleModel();
});

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ChangeNotifierProvider Example'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final peopleModel = ref.watch(peopleProvider);
          return ListView.separated(
            itemBuilder: (context, index) {
              final person = peopleModel.people.elementAt(index);
              return GestureDetector(
                onTap: () async {
                  final updatedPerson = await createOrUpdatePersonDialog(
                    context,
                    person,
                  );

                  if (updatedPerson != null) {
                    peopleModel.update(updatedPerson);
                  }
                },
                child: ListTile(
                  title: Text(person.displayName),
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: peopleModel.count,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(
            context,
          );
          if (person != null) {
            ref.read(peopleProvider).add(person);
          }
        },
        child: const Tooltip(
          message: 'Create new Person',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existedPerson,
]) {
  String? name = existedPerson?.name;
  int? age = existedPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age != null ? age.toString() : '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          existedPerson == null ? 'Create a person' : 'Update a person',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter name here ...',
              ),
              onChanged: (value) => name = value.trim(),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter age here ...',
              ),
              onChanged: (value) => age = int.tryParse(value.trim()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existedPerson != null) {
                  // have existing person, need to update
                  final newPerson = existedPerson.update(name, age);
                  Navigator.of(context).pop(newPerson);
                } else {
                  // no existing person, need to create
                  Navigator.of(context).pop(Person(name: name!, age: age!));
                }
              } else {
                // no name, or age, or both
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'check fields, and try again!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.red.shade700),
                    ),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
