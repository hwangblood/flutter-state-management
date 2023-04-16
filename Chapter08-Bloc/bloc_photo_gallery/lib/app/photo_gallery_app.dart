import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_photo_gallery/bloc/app_bloc.dart';
import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/bloc/app_state.dart';
import 'package:bloc_photo_gallery/dialogs/auth_error_dialog.dart';
import 'package:bloc_photo_gallery/loading/loading_overlay.dart';
import 'package:bloc_photo_gallery/views/views.dart';

class PhotoGalleryApp extends StatelessWidget {
  const PhotoGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc()
        ..add(
          const AppEventInitial(),
        ),
      child: MaterialApp(
        title: 'Bloc Photo Gallery',
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            // loading overlay
            if (state.isLoading) {
              LoadingOverlay.instance().show(context, 'Loading...');
            } else {
              LoadingOverlay.instance().hide();
            }

            // show auth error
            final authError = state.authError;
            if (authError != null) {
              showAuthErrorDialog(context, authError: authError);
            }
          },
          builder: (context, state) {
            if (state is AppStateLoggedOut) {
              return const LoginView();
            } else if (state is AppStateLoggedIn) {
              return const PhotoGalleryView();
            } else if (state is AppStateInRegistrationView) {
              return const RegisterView();
            } else {
              // this should never happen
              return const Center(
                child: Text('This Widget should never be shoued.'),
              );
            }
          },
        ),
      ),
    );
  }
}
