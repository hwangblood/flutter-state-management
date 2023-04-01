import 'package:example2/models/models.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
abstract class SearchResult {
  const SearchResult();
}

@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

/// search successful but not fitted result
@immutable
class SearchResultEmpty implements SearchResult {
  const SearchResultEmpty();
}

@immutable
class SearchResultWithError implements SearchResult {
  final Object error;
  const SearchResultWithError(this.error);
}

@immutable
class SearchResultWithResults implements SearchResult {
  final List<Thing> results;
  const SearchResultWithResults(this.results);
}
