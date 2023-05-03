import 'package:flutter/material.dart';

import 'package:vanillacontacts_course/constants.dart';
import 'package:vanillacontacts_course/home_page.dart';
import 'package:vanillacontacts_course/new_contact_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}
