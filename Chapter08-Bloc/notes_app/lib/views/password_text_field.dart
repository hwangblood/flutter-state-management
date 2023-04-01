import 'package:flutter/material.dart';
import 'package:notes_app/strings.dart' as strings show enterYourPasswordHere;

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      obscuringCharacter: '⸰',
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: strings.enterYourPasswordHere,
      ),
    );
  }
}
