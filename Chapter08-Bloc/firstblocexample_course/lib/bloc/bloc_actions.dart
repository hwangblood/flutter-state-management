// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

import 'package:testingbloc_course/bloc/person.dart';

const person1Url = 'http://192.168.137.95:5500/api/person1.json';
const person2Url = 'http://192.168.137.95:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

class LoadPersonAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonAction({
    required this.url,
    required this.loader,
  });
}
