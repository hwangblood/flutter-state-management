import 'package:flutter/cupertino.dart';

import 'package:lottie/lottie.dart';

import 'package:riverpod_instagram/views/components/animations/models/lottie_animation.dart';

class LottieAniamtionWidget extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAniamtionWidget({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      repeat: repeat,
      reverse: reverse,
    );
  }
}
