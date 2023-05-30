import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';

class PostVideoWidget extends HookWidget {
  final Post post;
  const PostVideoWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final videoController = VideoPlayerController.network(post.fileUrl);
    final isVideoPlayerReady = useState(false);

    useEffect(
      () {
        videoController.initialize().then((value) {
          isVideoPlayerReady.value = true;
          videoController.setLooping(true);
          videoController.play();
        });
        return () {
          videoController.dispose();
        };
      },
      [videoController],
    );

    switch (isVideoPlayerReady.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(videoController),
        );
      case false:
        return const LoadingAnimationWidget();
      default:
        return const SimpleErrorAnimationWidget();
    }
  }
}
