import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/apis/login_api.dart';
import 'package:notes_app/apis/notes_api.dart';
import 'package:notes_app/bloc/actions.dart';
import 'package:notes_app/bloc/app_bloc.dart';
import 'package:notes_app/bloc/app_state.dart';
import 'package:notes_app/dialogs/loading_screen.dart';
import 'package:notes_app/dialogs/generic_dialog.dart' as generic_dialog;
import 'package:notes_app/models.dart';
import 'package:notes_app/strings.dart' as strings;
import 'package:notes_app/views/views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multistate Notes',
      home: BlocProvider(
        create: (context) => AppBloc(
          loginApi: LoginApi.instance(),
          notesApi: NotesApi.instance(),
        ),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(strings.homeTitle),
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // loading screen
          if (state.isLoading) {
            LoadingScreen.instance().show(
              context: context,
              text: strings.pleaseWait,
            );
          } else {
            LoadingScreen.instance().hide();
          }

          // display possible errors
          if (state.loginError != null) {
            generic_dialog.showGenericDialog<bool>(
              context: context,
              title: strings.loginErrorDialogTitle,
              content: strings.loginErrorDialogContent,
              optionsBuilder: () => {
                strings.ok: true,
              },
            );
          }

          // if we are logged in, but have no fetch notes, fetch them now
          if (state.isLoading == false &&
              state.loginError == null &&
              state.loginHandle == const LoginHandle.hwangblood() &&
              state.notes == null) {
            context.read<AppBloc>().add(const LoadNotesAction());
          }
        },
        builder: (context, state) {
          final notes = state.notes;
          if (notes == null) {
            return LoginView(
              onLoginTpped: (email, password) {
                context.read<AppBloc>().add(
                      LoginAction(
                        email: email,
                        password: password,
                      ),
                    );
              },
            );
          } else {
            return notes.toListView();
          }
        },
      ),
    );
  }
}
