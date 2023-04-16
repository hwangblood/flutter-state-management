import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:bloc_photo_gallery/app/photo_gallery_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const PhotoGalleryApp(),
  );
}
