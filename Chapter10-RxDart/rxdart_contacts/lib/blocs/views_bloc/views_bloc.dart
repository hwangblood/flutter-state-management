// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';

import '../base_bloc.dart';

import 'current_view.dart';

@immutable
class ViewsBloc implements BaseBloc {
  final Sink<CurrentView> currentViewSink;

  /// The first view should be login when app start
  final Stream<CurrentView> currentView;

  @override
  void dispose() {
    currentViewSink.close();
  }

  const ViewsBloc._({
    required this.currentViewSink,
    required this.currentView,
  });

  factory ViewsBloc() {
    final currentViewSubject = BehaviorSubject<CurrentView>();

    return ViewsBloc._(
      currentViewSink: currentViewSubject.sink,
      currentView: currentViewSubject.stream.startWith(CurrentView.login),
    );
  }
}
