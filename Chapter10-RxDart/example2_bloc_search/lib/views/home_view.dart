import 'package:example2/bloc/bloc.dart';
import 'package:example2/widgets/seach_result_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(api: Api());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search App with BloC Pattern'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your search term here...',
              ),
              onChanged: _searchBloc.searchSink.add,
            ),
            const SizedBox(height: 16),
            SearchResultWidget(searchResult: _searchBloc.results),
          ],
        ),
      ),
    );
  }
}
