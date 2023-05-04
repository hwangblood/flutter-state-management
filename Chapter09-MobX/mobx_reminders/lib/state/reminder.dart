import 'package:mobx/mobx.dart';

part 'reminder.g.dart';

class Reminder = ReminderBase with _$Reminder;

abstract class ReminderBase with Store {
  final String id;
  final DateTime createAt;

  @observable
  String text;

  @observable
  bool isDone;

  ReminderBase({
    required this.id,
    required this.createAt,
    required this.text,
    required this.isDone,
  });

  @override
  bool operator ==(covariant ReminderBase other) =>
      id == other.id &&
      createAt == other.createAt &&
      text == other.text &&
      isDone == other.isDone;

  @override
  int get hashCode => Object.hash(
        id,
        createAt,
        text,
        isDone,
      );
}
