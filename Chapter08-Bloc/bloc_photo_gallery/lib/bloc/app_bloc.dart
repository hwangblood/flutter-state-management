import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppStateLoggedOut(isLoading: false),
        );

  /// Each user have their own storage folder named with [userId]
  Future<Iterable<Reference>> _fetchImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
