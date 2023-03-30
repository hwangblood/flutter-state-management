import 'dart:convert';
import 'dart:io';

import 'package:example2/models/models.dart';

// TODO Replace json url with yours
const animalsUrl = 'http://192.168.113.83:5500/apis/animals.json';
const personsUrl = 'http://192.168.113.83:5500/apis/persons.json';

typedef SearchTerm = String;

class Api {
  List<Animal>? _animals; // Caching Animal objects in memory
  List<Person>? _persons; // Caching Person objects in memory
  Api();

  /// Search by term param from cache or network, return an empty list if no
  /// conditional things found
  Future<List<Thing>> search(SearchTerm searchTerm) async {
    final term = searchTerm.trim().toLowerCase();
    // saerch in the cache
    final cachedResults = _extractThingsUsingSearchTerm(term);
    if (cachedResults != null) {
      return cachedResults;
    }

    // we don't have the values cached, let's call APIs

    // calling persons api and caching it
    final persons = await _fetchData(personsUrl).then(
      (json) => json.map((value) => Person.fromJson(value)),
    );
    _persons = persons.toList();

    // calling animals api and caching it
    final animals = await _fetchData(animalsUrl).then(
      (json) => json.map((value) => Animal.fromJson(value)),
    );
    _animals = animals.toList();

    return _extractThingsUsingSearchTerm(term) ?? [];
  }

  List<Thing>? _extractThingsUsingSearchTerm(SearchTerm term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;
    if (cachedAnimals != null && cachedPersons != null) {
      List<Thing> result = [];
      // go through animals
      for (var animal in cachedAnimals) {
        if (animal.name.trimmedContains(term) ||
            animal.type.name.trimmedContains(term)) {
          result.add(animal);
        }
      }
      // go through persons
      for (var person in cachedPersons) {
        if (person.name.trimmedContains(term) ||
            person.age.toString().trimmedContains(term)) {
          result.add(person);
        }
      }

      return result;
    }
    return null;
  }

  Future<List<dynamic>> _fetchData(String url) => HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((jsonString) => json.decode(jsonString) as List<dynamic>);
}

extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) => trim().toLowerCase().contains(
        other.trim().toLowerCase(),
      );
}
