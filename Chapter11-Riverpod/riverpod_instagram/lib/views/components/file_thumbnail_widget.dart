import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/image_upload/models/thumbnail_request.dart';
import 'package:riverpod_instagram/state/image_upload/providers/thumbnail_provider.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';

class FileThumbnailWidget extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const FileThumbnailWidget({
    Key? key,
    required this.thumbnailRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(thumbnailRequest),
    );

    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      loading: () {
        return const LoadingAnimationWidget();
      },
      error: (error, stackTrace) {
        return const SimpleErrorAnimationWidget();
      },
    );
  }
}
