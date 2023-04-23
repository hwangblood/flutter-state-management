import 'package:flutter/material.dart';

import 'package:riverpod_instagram/views/components/animations/empty_content_animation_widget.dart';

class EmptyContentWithTextAnimationWidget extends StatelessWidget {
  final String text;
  const EmptyContentWithTextAnimationWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge
              // ?.copyWith(color: Colors.white54)
              ,
            ),
          ),
          const EmptyContentAnimationWidget(),
        ],
      ),
    );
  }
  // animation: LottieAnimation.empty,
}
