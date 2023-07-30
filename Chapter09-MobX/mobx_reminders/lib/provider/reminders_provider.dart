import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx_reminders/state/reminder.dart';

typedef ReminderId = String;

abstract class _DocumentKeys {
  static const String text = 'text';
  static const String createAt = 'create_at';
  static const String isDone = 'is_done';
}

/// We are storing user's reminders in a collection with the same name as the their user id
abstract class RemindersProvider {
  Future<void> deleteReminderWithId(
    ReminderId reminderId, {
    required String userId,
  });

  Future<void> deleteAllReminders({
    required String userId,
  });

  Future<ReminderId> createReminder({
    required String userId,
    required String text,
    required DateTime creationDate,
  });

  Future<void> modify({
    required ReminderId reminderId,
    required bool isDone,
    required String userId,
  });
  Future<Iterable<Reminder>> loadReminders({
    required String userId,
  });
}

class FirestoreRemindersProvider extends RemindersProvider {
  @override
  Future<ReminderId> createReminder({
    required String userId,
    required String text,
    required DateTime creationDate,
  }) async {
    final createAt = DateTime.now();
    // create the firestore reminder
    final firestoreReminder =
        await FirebaseFirestore.instance.collection(userId).add({
      _DocumentKeys.text: text,
      _DocumentKeys.createAt: createAt.toIso8601String(),
      _DocumentKeys.isDone: false,
    });
    return firestoreReminder.id;
  }

  @override
  Future<void> deleteAllReminders({
    required String userId,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final operation = firestore.batch();
    final collection = await firestore.collection(userId).get();
    for (final document in collection.docs) {
      operation.delete(document.reference);
    }
    // delete all reminders for current user on Firebase
    await operation.commit();
  }

  @override
  Future<void> deleteReminderWithId(
    ReminderId reminderId, {
    required String userId,
  }) async {
    final colletion = await FirebaseFirestore.instance.collection(userId).get();
    // delete from Cloud Firestore
    final storedReminder = colletion.docs.firstWhere(
      (doc) => doc.id == reminderId,
    );
    await storedReminder.reference.delete();
  }

  @override
  Future<Iterable<Reminder>> loadReminders({
    required String userId,
  }) async {
    final collection =
        await FirebaseFirestore.instance.collection(userId).get();
    final storedReminders = collection.docs.map(
      (doc) => Reminder(
        id: doc.id,
        createAt: DateTime.parse(doc[_DocumentKeys.createAt] as String),
        text: doc[_DocumentKeys.text] as String,
        isDone: doc[_DocumentKeys.isDone] as bool,
      ),
    );

    return storedReminders;
  }

  @override
  Future<void> modify({
    required ReminderId reminderId,
    required bool isDone,
    required String userId,
  }) async {
    // update the remote reminder
    final colletion = await FirebaseFirestore.instance.collection(userId).get();
    final storedReminder = colletion.docs
        .firstWhere(
          (element) => element.id == reminderId,
        )
        .reference;
    await storedReminder.update({
      _DocumentKeys.isDone: isDone,
    });
  }
}
