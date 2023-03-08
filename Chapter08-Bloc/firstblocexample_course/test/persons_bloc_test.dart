import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:testingbloc_course/bloc/person.dart';
import 'package:testingbloc_course/bloc/persons_bloc.dart';

const mockedPersons1 = [
  Person(name: 'Foo 1', age: 20),
  Person(name: 'Baz 1', age: 25),
];

const mockedPersons2 = [
  Person(name: 'Foo 2', age: 20),
  Person(name: 'Baz 2', age: 25),
];

Future<Iterable<Person>> mockedGetPersons1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockedGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    // Write our tests
    late PersonsBloc bloc;

    // call it per test in this group
    setUp(() {
      bloc = PersonsBloc();
    });
  });
}
