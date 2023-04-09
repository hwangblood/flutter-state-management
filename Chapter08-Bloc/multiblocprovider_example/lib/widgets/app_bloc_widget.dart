import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app_bloc.dart';
import '../blocs/app_event.dart';
import '../blocs/app_state.dart';
import '../extensions.dart';

class AppBlocWidget<T extends AppBloc> extends StatelessWidget {
  const AppBlocWidget({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, state) {
          if (state.error != null) {
            return const Center(
              child: Text('An error occurred. Try again in a moment!'),
            );
          } else if (state.data != null) {
            return Image.memory(
              state.data!,
              fit: BoxFit.fitHeight,
            );
          } else /* if (state.isLoading) */ {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
