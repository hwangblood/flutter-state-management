import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bloc_photo_gallery/bloc/app_bloc.dart';
import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/bloc/app_state.dart';
import 'package:bloc_photo_gallery/widgets/main_popup_menu_button.dart';
import 'package:bloc_photo_gallery/widgets/storage_image_widget.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(
      () => ImagePicker(),
      [key],
    );

    final Iterable<Reference> imageRefs =
        context.read<AppBloc>().state.images ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              // Use BuildContext before await function
              final appBloc = context.read<AppBloc>();

              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image == null) {
                return;
              }

              // submit uploading-image event
              final imagePath = image.path;
              appBloc.add(
                AppEventUploadImage(filePath: imagePath),
              );
            },
            icon: const Icon(Icons.upload),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(8.0),
        children: imageRefs
            .map(
              (imageRef) => StorageImageWidget(
                imageRef: imageRef,
              ),
            )
            .toList(),
      ),
    );
  }
}
