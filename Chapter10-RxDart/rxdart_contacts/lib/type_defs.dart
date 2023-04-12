import 'package:flutter/foundation.dart';

import 'models/contact.dart';

typedef LogoutCallback = VoidCallback;

typedef DeleteAccountCallback = VoidCallback;

typedef GoBackCallback = VoidCallback;

typedef LoginCallback = void Function(
  String email,
  String password,
);

typedef RegisterCallback = void Function(
  String email,
  String password,
);

typedef CreateContactCallback = void Function(
  String firstName,
  String lastName,
  String phoneNumber,
);

typedef DeleteContactCallback = void Function(
  Contact contact,
);
