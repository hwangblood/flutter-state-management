// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      theme: ThemeData.dark(),
      title: 'Riverpod Course',
      home: const HomePage(),
    );
  }
}

@immutable
class Film {
  final String id;
  final String title;
  final String desciption;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.desciption,
    required this.isFavorite,
  });

  @override
  String toString() {
    return 'Film(id: $id, title: $title, desciption: $desciption, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll([
        id,
        // title,
        // desciption,
        isFavorite,
      ]);

  Film copyWith({
    bool? isFavorite,
  }) {
    return Film(
      id: id,
      title: title,
      desciption: desciption,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

const allFilms = [
  Film(
    id: '1',
    title: 'Film 1',
    desciption: 'Desc for film 1',
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: 'Film 2',
    desciption: 'Desc for film 2',
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: 'Film 3',
    desciption: 'Desc for film 3',
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: 'Film 4',
    desciption: 'Desc for film 4',
    isFavorite: false,
  ),
  Film(
    id: '5',
    title: 'Film 5',
    desciption: 'Desc for film 5',
    isFavorite: false,
  ),
];

class FilmsNotifier extends StateNotifier<Iterable<Film>> {
  FilmsNotifier() : super(allFilms);

  void updateFavorite({
    required Film film,
    required bool isFavorite,
  }) {
    state = state.map(
      (nowFilm) => nowFilm.id == film.id
          ? film.copyWith(isFavorite: isFavorite)
          : nowFilm,
    );
  }
}

enum FilterType {
  all,
  favorite,
  notFavorite,
}

final filterProvider = StateProvider<FilterType>((ref) {
  return FilterType.all;
});

/// all films
final allFilmsProvider =
    StateNotifierProvider<FilmsNotifier, Iterable<Film>>((ref) {
  return FilmsNotifier();
});

/// favorite films
final favoriteFilmsProvider = Provider<Iterable<Film>>((ref) {
  return ref.watch(allFilmsProvider).where(
        (film) => film.isFavorite,
      );
});

/// not-favorite films
final notFavoriteFilmsProvider = Provider<Iterable<Film>>((ref) {
  return ref.watch(allFilmsProvider).where(
        (film) => !film.isFavorite,
      );
});

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Films Filter'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: FilterWidget(),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final filterType = ref.watch(filterProvider);
                switch (filterType) {
                  case FilterType.all:
                    return FilmsList(provider: allFilmsProvider);
                  case FilterType.favorite:
                    return FilmsList(provider: favoriteFilmsProvider);
                  case FilterType.notFavorite:
                    return FilmsList(provider: notFavoriteFilmsProvider);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;

  const FilmsList({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return ListView.separated(
      itemCount: films.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final film = films.elementAt(index);
        final favotiteIcon = Icon(
          film.isFavorite ? Icons.favorite : Icons.favorite_outline,
        );
        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.desciption),
          trailing: IconButton(
            onPressed: () {
              final isFavorite = !film.isFavorite;
              ref.read(allFilmsProvider.notifier).updateFavorite(
                    film: film,
                    isFavorite: isFavorite,
                  );
            },
            icon: favotiteIcon,
          ),
        );
      },
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton<FilterType>(
          value: ref.watch(filterProvider),
          items: FilterType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              // eg: 'FilterType.all' => 'all'
              child: Text(type.toString().split('.').last),
            );
          }).toList(),
          onChanged: (value) {
            ref.read(filterProvider.notifier).state = value!;
          },
        );
      },
    );
  }
}
