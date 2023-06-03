import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/state/image_upload/helpers/image_picker_helper.dart';
import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/post_setting/providers/post_setting_provider.dart';
import 'package:riverpod_instagram/views/components/dialogs/alert_dialog_model.dart';
import 'package:riverpod_instagram/views/components/dialogs/logout_dialog.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';
import 'package:riverpod_instagram/views/create_new_post/create_new_post_view.dart';
import 'package:riverpod_instagram/views/tabs/home/home_view.dart';
import 'package:riverpod_instagram/views/tabs/search_posts/search_posts_view.dart';
import 'package:riverpod_instagram/views/tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                // pick a video first
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();

                if (videoFile == null) {
                  return;
                }
                // reset the postSetting, because we wanna create a new post
                // ignore: unused_result
                ref.refresh(postSettingNotifierProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.of(context).push(
                  CreateNewPostView.route(
                    fileToPost: videoFile,
                    fileType: FileType.video,
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
              onPressed: () async {
                // pick a image first
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();

                if (imageFile == null) {
                  return;
                }
                // reset the postSetting, because we wanna create a new post
                // ignore: unused_result
                ref.refresh(postSettingNotifierProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.of(context).push(
                  CreateNewPostView.route(
                    fileToPost: imageFile,
                    fileType: FileType.image,
                  ),
                );
              },
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogout = await LogoutDialog().present(context).then(
                      (value) => value ?? false,
                    );
                if (shouldLogout) {
                  await ref.read(authStateNotifierProvider.notifier).logout();
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchPostsView(),
            UerPostsView(),
          ],
        ),
      ),
    );
  }
}
