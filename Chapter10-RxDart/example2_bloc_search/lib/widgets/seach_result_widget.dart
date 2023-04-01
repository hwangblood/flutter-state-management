import 'package:example2/bloc/bloc.dart';
import 'package:example2/models/models.dart';
import 'package:flutter/material.dart';

class SearchResultWidget extends StatelessWidget {
  final Stream<SearchResult?> searchResult;

  const SearchResultWidget({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
      stream: searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultWithError) {
            return const Text('Got error');
          } else if (result is SearchResultLoading) {
            return const CircularProgressIndicator();
          } else if (result is SearchResultEmpty) {
            return const Text(
              'No results found for your search term. Try with another one!',
            );
          } else if (result is SearchResultWithResults) {
            final results = result.results;
            return Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final item = results[index];
                  final String title;
                  if (item is Animal) {
                    title = 'Animal';
                  } else if (item is Person) {
                    title = 'Person';
                  } else {
                    title = 'Unknown';
                  }
                  return ListTile(
                    title: Text('${index + 1} - $title'),
                    subtitle: Text(
                      item.toString(),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('Unknown state!');
          }
        } else {
          return const Text('Waiting for typing');
        }
      },
    );
  }
}
