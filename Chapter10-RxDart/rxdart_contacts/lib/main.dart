import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'blocs/app_bloc/app_bloc.dart';
import 'blocs/auth_bloc/auth_error.dart';
import 'blocs/views_bloc/current_view.dart';
import 'dialogs/auth_error_dialog.dart';
import 'firebase_options.dart';
import 'loading/loading_scrren.dart';
import 'views/contacts_list_view.dart';
import 'views/create_contact_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Contacts with RxDart',
      home: ViewSwitcher(),
    );
  }
}

class ViewSwitcher extends StatefulWidget {
  const ViewSwitcher({Key? key}) : super(key: key);

  @override
  State<ViewSwitcher> createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  late final AppBloc appBloc;
  StreamSubscription<AuthError?>? _authErrorSub;
  StreamSubscription<bool>? _isLoadingSub;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
  }

  @override
  void dispose() {
    appBloc.dispose();
    _authErrorSub?.cancel();
    _isLoadingSub?.cancel();
    super.dispose();
  }

  void handleAuthErrors(BuildContext context) async {
    await _authErrorSub?.cancel();
    _authErrorSub = appBloc.authError.listen((event) {
      final AuthError? authError = event;
      if (authError == null) {
        return;
      }
      showAuthErrorDialog(
        context,
        authError: authError,
      );
    });
  }

  void setupLoadingScreen(BuildContext context) async {
    await _isLoadingSub?.cancel();
    _isLoadingSub = appBloc.isLoading.listen((isLoading) {
      if (isLoading) {
        LoadingScreen.instance().show(
          context,
          'Loading...',
        );
      } else {
        LoadingScreen.instance().hide();
      }
    });
  }

  Widget buildHome() {
    return StreamBuilder<CurrentView>(
      stream: appBloc.currentView,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final currentView = snapshot.requireData;
            switch (currentView) {
              case CurrentView.login:
                return LoginView(
                  login: appBloc.login,
                  navToRegisterView: appBloc.navigateToRegisterView,
                );
              case CurrentView.register:
                return RegisterView(
                  register: appBloc.register,
                  navToLoginView: appBloc.navigateToLoginView,
                );
              case CurrentView.contactList:
                return ContactsListView(
                  logout: appBloc.logout,
                  deleteAccount: appBloc.deleteAccount,
                  deleteContact: appBloc.deleteContact,
                  contactsStream: appBloc.contacts,
                  navToCreateContact: appBloc.navigateToCreateContactView,
                );
              case CurrentView.createContact:
                return CreateContactView(
                  createContact: appBloc.createContact,
                  goBack: appBloc.navigateToContactsListView,
                );
            }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    handleAuthErrors(context);
    setupLoadingScreen(context);
    return buildHome();
  }
}
