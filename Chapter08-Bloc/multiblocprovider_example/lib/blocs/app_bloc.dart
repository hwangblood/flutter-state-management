import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../extensions.dart';
import 'app_event.dart';
import 'app_state.dart';

typedef RandomUrlPicker = String Function(Iterable<String> urls);

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> urls) => urls.random();
  AppBloc({
    required Iterable<String> urls,
    Duration? extraLoading,
    RandomUrlPicker? urlPicker,
  }) : super(const AppState.empty()) {
    on<LoadNextUrlEvent>((event, emit) async {
      // start loading
      emit(
        const AppState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );

      // Optional loading
      if (extraLoading != null) {
        await Future.delayed(extraLoading);
      }

      try {
        final url = (urlPicker ?? _pickRandomUrl)(urls);
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();
        emit(
          AppState(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          AppState(
            isLoading: false,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
