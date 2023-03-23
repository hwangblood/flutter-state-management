import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  /// Transform elements by transform function, if transform is null return
  /// the element
  ///
  /// Example:
  ///
  /// [1, 2, null, 3].compactMap((n) => n == null ? 0 : (n * n))
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) => map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

const url =
    'https://img-cf.xvideos-cdn.com/videos/thumbs169poster/1b/84/46/1b84467bb828f25ab0268c33c79ee4cd-3/1b84467bb828f25ab0268c33c79ee4cd.3.jpg';

class UseFuturePage extends HookWidget {
  const UseFuturePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Caching the Future<Image>, or it will re-download image over and over
    // again, when call build function
    final imageFuture = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data)));
    final snapshot = useFuture(imageFuture);

    return Scaffold(
      appBar: AppBar(title: const Text('useFuture Example')),
      body: Column(
        children: [
          snapshot.hasData ? snapshot.data! : null,
          const Center(
            child: Text('Caching Future<Image> object with useMemoized hook.'),
          ),
        ].compactMap().toList(),
      ),
    );
  }
}
