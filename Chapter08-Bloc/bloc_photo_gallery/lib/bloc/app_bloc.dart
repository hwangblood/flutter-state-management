import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/bloc/app_state.dart';
import 'package:bloc_photo_gallery/utils/upload_image.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppStateLoggedOut(isLoading: false),
        ) {
    // handle uploading images
    on<AppEventUploadImage>((event, emit) async {
      final User? user = state.user;
      // log out user if we don't have valid user in app state
      if (user == null) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
        // stop doing next things if user is null
        return;
      }

      // start loading process
      emit(
        AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: true,
        ),
      );

      // upload the file
      final file = File(event.filePath);
      // In fact, this app doesn't care about whether the file is successfully uploaded or not
      // ignore: unused_local_variable
      bool uploadResult = await uploadImage(userId: user.uid, file: file);
      // after upload is completed, grap the latest file references
      final images = await _fetchImages(user.uid);
      // emit the new images and turn off loading
      emit(
        AppStateLoggedIn(
          user: user,
          images: images,
          isLoading: false,
        ),
      );
    });
  }

  /// Each user have their own storage folder named with [userId]
  Future<Iterable<Reference>> _fetchImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
