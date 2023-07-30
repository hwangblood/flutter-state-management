import 'package:flutter/material.dart';

extension IterableToListView<T> on Iterable<T> {
  IterableListView toListView() => IterableListView(iterable: this);
}

class IterableListView<T> extends StatelessWidget {
  final Iterable<T> iterable;
  const IterableListView({super.key, required this.iterable});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        title: Text(
          iterable.elementAt(index).toString(),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: iterable.length,
    );
  }
}
