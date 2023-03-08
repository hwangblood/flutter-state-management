import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:testingbloc_course/bloc/bloc_actions.dart';
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
  group(
    'Testing bloc',
    () {
      // Write our tests
      late PersonsBloc bloc;

      // call it per test in this group
      setUp(() {
        bloc = PersonsBloc();
      });

      blocTest<PersonsBloc, FetchResult?>(
        'Test initial state',
        build: () => bloc,
        verify: (bloc) => expect(
          bloc.state == null,
          true,
        ),
      );

      // fetch mocked data (persons1) and compare it with FetchResult
      blocTest(
        'Mock retrieving persons from fist iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'bummy_url_1',
              loader: mockedGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'bummy_url_1',
              loader: mockedGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPersons1, isRetrievedFromCache: false),
          const FetchResult(
              persons: mockedPersons1, isRetrievedFromCache: true),
        ],
      );

      // fetch mocked data (persons2) and compare it with FetchResult
      blocTest(
        'Mock retrieving persons from second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'bummy_url_2',
              loader: mockedGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'bummy_url_2',
              loader: mockedGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPersons2, isRetrievedFromCache: false),
          const FetchResult(
              persons: mockedPersons2, isRetrievedFromCache: true),
        ],
      );
    },
  );
}
