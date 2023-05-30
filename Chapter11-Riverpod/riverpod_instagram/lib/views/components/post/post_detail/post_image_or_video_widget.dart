import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/post_image_widget.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/post_video_widget.dart';

class PostImageOrVideoWidget extends StatelessWidget {
  final Post post;
  const PostImageOrVideoWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageWidget(post: post);
      case FileType.video:
        return PostVideoWidget(post: post);
    }
  }
}
