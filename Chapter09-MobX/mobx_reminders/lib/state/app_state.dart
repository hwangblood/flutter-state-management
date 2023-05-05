import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx_reminders/state/reminder.dart';

abstract class _DocumentKeys {
  static const String text = 'text';
  static const String createAt = 'create_at';
  static const String isDone = 'is_done';
}

typedef LoginOrRegisterFunction = Future<UserCredential> Function({
  required String email,
  required String password,
});

extension ToInt on bool {
  /// Convert false to 0, true to 1
  int toInteger() => this ? 1 : 0;
}

extension Sorted on Iterable<Reminder> {
  /// Sort Reminders by isDone and createAt
  ///
  /// Iterable.sort() example:
  /// ```dart
  /// final numbers = <String>['two', 'three', 'four'];
  /// Sort from shortest to longest.
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [two, four, three]
  /// ```
  Iterable<Reminder> sorted() => [...this]..sort((a, b) {
      final isDone = a.isDone.toInteger().compareTo(b.isDone.toInteger());
      if (isDone != 0) {
        return isDone;
      }
      return a.createAt.compareTo(b.createAt);
    });
}
