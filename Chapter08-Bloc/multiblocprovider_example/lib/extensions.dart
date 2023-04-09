import 'dart:math' as math;

// ignore: depend_on_referenced_packages
import 'package:async/async.dart' show StreamGroup;

// ignore: depend_on_referenced_packages

extension StartWith<T> on Stream<T> {
  /// this:          | -------- X ------ X
  /// Stream.value:  | X |
  /// merge:         | X ------ X ------ X
  Stream<T> startWith(T value) => StreamGroup.merge([
        this,
        Stream.value(value),
      ]);
}

extension RandomElement<T> on Iterable<T> {
  /// Get a random element from [Iterable]
  T random() => elementAt(math.Random().nextInt(length));
}
