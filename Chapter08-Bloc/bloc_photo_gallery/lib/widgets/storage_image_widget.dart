import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

/// Display a image by [Reference] that from Firebase Storage
class StorageImageWidget extends StatelessWidget {
  /// Reference for image that from Firebase Storage
  final Reference imageRef;

  const StorageImageWidget({
    super.key,
    required this.imageRef,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: imageRef.getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Image.memory(
                data!,
                fit: BoxFit.cover,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        }
      },
    );
  }
}
