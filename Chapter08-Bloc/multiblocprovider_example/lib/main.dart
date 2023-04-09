import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiblocprovider_example/blocs/top_bloc.dart';
import 'package:multiblocprovider_example/constants.dart';
import 'package:multiblocprovider_example/widgets/app_bloc_widget.dart';

import 'blocs/bottom_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MultiBlocProvider Example',
      home: HomePage(),
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TopBloc(
                extraLoading: const Duration(seconds: 3),
                urls: namiImages,
              ),
            ),
            BlocProvider(
              create: (context) => BottomBloc(
                extraLoading: const Duration(seconds: 5),
                urls: robinImages,
              ),
            ),
          ],
          child: Column(
            children: const [
              AppBlocWidget<TopBloc>(),
              AppBlocWidget<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
