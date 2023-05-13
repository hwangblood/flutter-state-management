import 'package:flutter/foundation.dart' show immutable;

import 'package:riverpod_instagram/views/components/constants/strings.dart';
import 'package:riverpod_instagram/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  DeleteDialog({
    required String titleOfObjectToDelete,
  }) : super(
          title: '${Strings.delete} $titleOfObjectToDelete',
          message:
              '${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete',
          buttons: {
            Strings.cancel: false,
            Strings.delete: true,
          },
        );
}
