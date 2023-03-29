import 'package:flutter/foundation.dart' show immutable;
import 'package:example2/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class SearchBloc {
  final Sink<String> searchSink;
  final Stream<SearchResult?> results;

  void dispose() {
    searchSink.close();
  }

  factory SearchBloc({required Api api}) {
    final textChanges = BehaviorSubject<String>();

    final results = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<SearchResult?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        // search is empty
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(seconds: 1))
            .map(
              (results) => results.isEmpty
                  ? const SearchResultEmpty()
                  : SearchResultWithResults(results),
            )
            .startWith(const SearchResultLoading())
            .onErrorReturnWith((error, _) => SearchResultWithError(error));
      }
    });

    return SearchBloc._(
      searchSink: textChanges.sink,
      results: results,
    );
  }

  const SearchBloc._({
    required this.searchSink,
    required this.results,
  });
}
