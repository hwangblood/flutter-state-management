import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/image_upload/models/thumbnail_request.dart';
import 'package:riverpod_instagram/state/image_upload/providers/image_uploader_provider.dart';
import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';
import 'package:riverpod_instagram/state/post_setting/providers/post_setting_provider.dart';
import 'package:riverpod_instagram/views/components/file_thumbnail_widget.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  static MaterialPageRoute route({
    required File fileToPost,
    required FileType fileType,
  }) =>
      MaterialPageRoute(
        builder: (context) => CreateNewPostView(
          fileToPost: fileToPost,
          fileType: fileType,
        ),
      );

  const CreateNewPostView({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final currentPostSetting = ref.watch(postSettingNotifierProvider);
    final messageController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isPostButtonEnabled.value = messageController.text.isNotEmpty;
        }

        messageController.addListener(listener);
        return () {
          messageController.removeListener(listener);
        };
      },
      [messageController],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = messageController.text;
                    final isUploaded = await ref
                        .read(imageUploaderNotifierProvider.notifier)
                        .upload(
                          userId: userId,
                          file: widget.fileToPost,
                          fileType: widget.fileType,
                          message: message,
                          postSetting: currentPostSetting,
                        );
                    if (isUploaded && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('uploading success'),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // thumbnail
            FileThumbnailWidget(
              thumbnailRequest: thumbnailRequest,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: messageController,
                autocorrect: true,
                maxLines: null, // default 1 line
                decoration: const InputDecoration(
                  hintText: Strings.pleaseWriteYourMessageHere,
                ),
              ),
            ),

            ...PostSetting.values.map(
              (postSetting) => ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.description),
                trailing: Switch(
                  value: currentPostSetting[postSetting] ?? false,
                  onChanged: (onOrOff) {
                    ref
                        .read(postSettingNotifierProvider.notifier)
                        .setSetting(postSetting, onOrOff);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
