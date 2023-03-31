import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/apis/login_api.dart';
import 'package:notes_app/apis/notes_api.dart';
import 'package:notes_app/bloc/actions.dart';
import 'package:notes_app/bloc/app_state.dart';
import 'package:notes_app/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // start loading
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          notes: null,
        ),
      );

      // log the user in
      final loginHandle =
          await loginApi.login(email: event.email, password: event.password);

      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          notes: null,
        ),
      );
    });
    on<LoadNotesAction>((event, emit) async {
      // start loading
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: state.loginHandle,
          notes: null,
        ),
      );

      // get the loginHandle
      final loginHandle = state.loginHandle;

      if (loginHandle != const LoginHandle.hwangblood()) {
        // invalid login handle, can't fetch notes
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            notes: null,
          ),
        );

        return;
      }

      // when login handle is valid, and want to fetch notes
      final notes = await notesApi.getNotes(loginHandle: state.loginHandle!);

      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: loginHandle,
          notes: notes,
        ),
      );
    });
  }
}
