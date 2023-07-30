import 'package:flutter/foundation.dart' show immutable;
import 'package:notes_app/models.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocol {
  // Singleton pattern
  const NotesApi._sharedInstance();
  static const NotesApi _shared = NotesApi._sharedInstance();

  factory NotesApi.instance() => _shared;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => loginHandle == const LoginHandle.hwangblood() ? mockedNotes : null,
    );
  }
}
