import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:riverpod_instagram/views/constants/app_colors.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.google,
            color: AppColors.googleColor,
          ),
          const SizedBox(width: 8.0),
          const Text(Strings.google),
        ],
      ),
    );
  }
}
