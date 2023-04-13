// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';

import '../../models/contact.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_error.dart';
import '../base_bloc.dart';
import '../contacts_bloc/contacts_bloc.dart';
import '../views_bloc/current_view.dart';
import '../views_bloc/views_bloc.dart';

/// Wrap all internal blocs to one bloc that exposed to ui.
/// Hide the complexity of all other blocs
@immutable
class AppBloc implements BaseBloc {
  final AuthBloc _authBloc;
  final ViewsBloc _viewsBloc;
  final ContactsBloc _contactsBloc;

  final Stream<CurrentView> currentView;

  /// Any async operator could have loading state
  final Stream<bool> isLoading;

  final Stream<AuthError?> authError;

  /// when user logged out, app should navigate to Login page
  final StreamSubscription<String?> _userIdSubscription;

  Stream<Iterable<Contact>> get contacts => _contactsBloc.contacts;

  const AppBloc._({
    required AuthBloc authBloc,
    required ViewsBloc viewsBloc,
    required ContactsBloc contactsBloc,
    required this.currentView,
    required this.isLoading,
    required this.authError,
    required StreamSubscription<String?> userIdSubscription,
  })  : _authBloc = authBloc,
        _viewsBloc = viewsBloc,
        _contactsBloc = contactsBloc,
        _userIdSubscription = userIdSubscription;

  factory AppBloc() {
    final authBloc = AuthBloc();
    final viewsBloc = ViewsBloc();
    final contactsBloc = ContactsBloc();

    // pass user id from auth bloc into contacts bloc
    final userIdSubscription = authBloc.userId.listen((String? userId) {
      contactsBloc.userId.add(userId);
    });

    // calclate the current view
    final Stream<CurrentView> currentViewBasedOnAuthStatus =
        authBloc.authState.map<CurrentView>((authState) {
      if (authState is AuthStateLoggedIn) {
        return CurrentView.contactList;
      } else {
        return CurrentView.login;
      }
    });
    //  current view
    final Stream<CurrentView> currentView = Rx.merge([
      viewsBloc.currentView,
      currentViewBasedOnAuthStatus,
    ]);

    // whether is loading
    final Stream<bool> isLoading = Rx.merge([
      authBloc.isLoading,
    ]);

    return AppBloc._(
      authBloc: authBloc,
      viewsBloc: viewsBloc,
      contactsBloc: contactsBloc,
      currentView: currentView,
      // why asBroadcastStream()?
      // if a Stream is listened by a Widget, or subscripted by a
      // StreamSubscription, and then the Widget destoried, or the
      // StreamSubscription called cancel(). you will cannot listen the Stream
      // again. so, instead it with asBroadcastStream().
      isLoading: isLoading.asBroadcastStream(),
      authError: authBloc.authError.asBroadcastStream(),
      userIdSubscription: userIdSubscription,
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    _viewsBloc.dispose();
    _contactsBloc.dispose();
    _userIdSubscription.cancel();
  }

  void deleteContact(Contact contact) {
    _contactsBloc.deleteContact.add(
      contact,
    );
  }

  void createContact(
    String firstName,
    String lastName,
    String phoneNumber,
  ) {
    _contactsBloc.createContact.add(
      Contact.withoutId(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      ),
    );
  }

  void login(
    String email,
    String password,
  ) {
    _authBloc.login.add(
      LoginAction(email, password),
    );
  }

  void register(
    String email,
    String password,
  ) {
    _authBloc.register.add(
      RegisterAction(email, password),
    );
  }

  void logout() {
    _authBloc.logout.add(
      null,
    );
  }

  void deleteAccount() {
    _contactsBloc.deleteAllContacts.add(null);
    _authBloc.deleteAccount.add(null);
  }

  void navigateToContactsListView() => _viewsBloc.currentViewSink.add(
        CurrentView.contactList,
      );

  void navigateToCreateContactView() => _viewsBloc.currentViewSink.add(
        CurrentView.createContact,
      );

  void navigateToRegisterView() => _viewsBloc.currentViewSink.add(
        CurrentView.register,
      );

  void navigateToLoginView() => _viewsBloc.currentViewSink.add(
        CurrentView.login,
      );
}
