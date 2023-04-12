// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../helpers/is_debugging.dart';
import '../type_defs.dart';

class CreateContactView extends HookWidget {
  final CreateContactCallback createContact;
  final GoBackCallback goBack;

  const CreateContactView({
    Key? key,
    required this.createContact,
    required this.goBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController(
      text: 'blood'.ifDebugging,
    );
    final lastNameController = useTextEditingController(
      text: 'hwang'.ifDebugging,
    );
    final phoneNumberController = useTextEditingController(
      text: '+461234567890'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: goBack,
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: const Text('Create a new Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: 'First name...',
              ),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'Last name...',
              ),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                hintText: 'Phone number...',
              ),
              keyboardType: TextInputType.phone,
            ),
            TextButton(
              onPressed: () {
                final firstName = firstNameController.text.trim();
                final lastName = lastNameController.text.trim();
                final phoneNumber = phoneNumberController.text.trim();
                createContact(
                  firstName,
                  lastName,
                  phoneNumber,
                );
                goBack();
              },
              child: const Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
