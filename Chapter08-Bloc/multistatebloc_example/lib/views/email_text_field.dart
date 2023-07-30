import 'package:flutter/material.dart';
import 'package:notes_app/strings.dart' as strings show enterYourEmailHere;

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: strings.enterYourEmailHere,
      ),
    );
  }
}
