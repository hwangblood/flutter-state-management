// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';

import '../../models/contact.dart';
import '../base_bloc.dart';

/// a series of documents from Cloud FireStore
typedef _Snapshot = QuerySnapshot<Map<String, dynamic>>;

/// a document from Cloud FireStore
typedef _Document = DocumentReference<Map<String, dynamic>>;

extension Unwarp<T> on Stream<T?> {
  /// Convert a optional value Stream<T?> to non-nullable value Stream<T>
  Stream<T> unwrap() => switchMap((T? value) async* {
        if (value != null) {
          yield value;
        }
      });
}

/// Cold Observable starts producing values as soon as you start listening or
/// subscribe to it. However, Hot Observable pruduces values even if no one is
/// listening to it.
///
/// Create and Delete contact actions are only used in [ContactsBloc], no one
/// from outside of [ContactsBloc] is going to listen to these signals, so they
/// should be Cold Observable
@immutable
class ContactsBloc implements BaseBloc {
  final Sink<String?> userId;

  final Sink<Contact> createContact;
  final Sink<Contact> deleteContact;

  final StreamSubscription<void> _createContactSubscription;
  final StreamSubscription<void> _deleteContactSubscription;

  /// Read-only Stream for displaying contacts
  final Stream<Iterable<Contact>> contacts;

  @override
  void dispose() {
    userId.close();
    createContact.close();
    deleteContact.close();
    _createContactSubscription.cancel();
    _deleteContactSubscription.cancel();
  }

  const ContactsBloc._({
    required this.userId,
    required this.createContact,
    required this.deleteContact,
    required StreamSubscription<void> createContactSubscription,
    required StreamSubscription<void> deleteContactSubscription,
    required this.contacts,
  })  : _createContactSubscription = createContactSubscription,
        _deleteContactSubscription = deleteContactSubscription;

  factory ContactsBloc() {
    final firestore = FirebaseFirestore.instance;

    // userId
    final userIdSubject = BehaviorSubject<String?>();

    // retrieve user's contacts, once userId has changed
    // progress in stream:
    // fetch data by userId --> collection that contains documents --> Iterable<Contact>
    final Stream<Iterable<Contact>> contactsStream =
        userIdSubject.switchMap<_Snapshot>((userId) {
      if (userId == null) {
        return const Stream<_Snapshot>.empty();
      } else {
        return firestore.collection(userId).snapshots();
      }
    }).map<Iterable<Contact>>((snapshot) sync* {
      for (final doc in snapshot.docs) {
        yield Contact.fromJson(doc.data(), id: doc.id);
      }
    });

    // create contact
    final createContactSubject = BehaviorSubject<Contact>();
    final createContactSubscription = createContactSubject
        // if you need a Future to come out of every elemant of a stream, using asyncMap()
        .switchMap(
          (contactToCreate) => userIdSubject
              // no null userId
              .unwrap()
              // take lastest userId
              .takeLast(1)
              // add a contact document to firestore upon userId
              .asyncMap(
                (userId) =>
                    firestore.collection(userId).add(contactToCreate.data),
              ),
        )
        .listen((event) {});

    // delete contact
    final deleteContactSubject = BehaviorSubject<Contact>();
    final StreamSubscription<void> deleteContactSubscription =
        deleteContactSubject
            .switchMap(
              (Contact contactToDelete) => userIdSubject
                  // no null userId
                  .unwrap()
                  // take lastest userId
                  .takeLast(1)
                  .asyncMap(
                    (userId) => firestore
                        .collection(userId)
                        .doc(contactToDelete.id)
                        .delete(),
                  ),
            )
            .listen((event) {});

    // create ContactsBloc
    return ContactsBloc._(
      userId: userIdSubject.sink,
      createContact: createContactSubject.sink,
      deleteContact: deleteContactSubject.sink,
      createContactSubscription: createContactSubscription,
      deleteContactSubscription: deleteContactSubscription,
      contacts: contactsStream,
    );
  }
}
