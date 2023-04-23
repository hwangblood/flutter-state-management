import 'package:riverpod_instagram/views/components/animations/lottie_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/models/lottie_animation.dart';

class EmptyContentAnimationWidget extends LottieAniamtionWidget {
  const EmptyContentAnimationWidget({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
