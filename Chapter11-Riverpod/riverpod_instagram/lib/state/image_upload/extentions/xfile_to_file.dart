import 'dart:io' show File;

import 'package:image_picker/image_picker.dart' show XFile;

extension FUTURXFILEToFile on Future<XFile?> {
  Future<File?> toFile() => then(
        (xFile) => xFile?.path,
      ).then(
        (filePath) => filePath != null ? File(filePath) : null,
      );
}
