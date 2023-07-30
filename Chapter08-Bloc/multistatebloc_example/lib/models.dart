// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  final String token;
  const LoginHandle({
    required this.token,
  });

  const LoginHandle.hwangblood() : token = 'hwangblood';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle(token: $token)';
}

enum LoginErrors { invalidHandle }

@immutable
class Note {
  final String title;
  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note(title: $title)';
}

final mockedNotes = Iterable.generate(
  5,
  (index) => Note(title: 'Note ${index + 1}'),
);
