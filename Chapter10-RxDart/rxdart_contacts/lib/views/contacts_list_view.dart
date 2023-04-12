// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../dialogs/delete_contact_dialog.dart';
import '../models/contact.dart';
import '../type_defs.dart';
import '../widgets/main_popup_menu_button.dart';

class ContactsListView extends StatelessWidget {
  final LogoutCallback logout;
  final DeleteAccountCallback deleteAccount;
  final DeleteContactCallback deleteContact;
  final VoidCallback navToCreateContact;
  final Stream<Iterable<Contact>> contactsStream;

  const ContactsListView({
    Key? key,
    required this.logout,
    required this.deleteAccount,
    required this.deleteContact,
    required this.navToCreateContact,
    required this.contactsStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
        actions: [
          MainPopupMenuButton(
            logout: logout,
            deleteAccount: deleteAccount,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navToCreateContact,
        child: const Tooltip(
          message: 'Create a new Contact',
          child: Icon(Icons.add),
        ),
      ),
      body: StreamBuilder(
        stream: contactsStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            // the stream should never be done to be honest with you
            // because our stream is never going to be closed
            case ConnectionState.done:
              final contacts = snapshot.requireData;
              return ListView.separated(
                itemBuilder: (context, index) {
                  final contact = contacts.elementAt(index);
                  return ContactListTile(
                    contact: contact,
                    deleteContact: deleteContact,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: contacts.length,
              );
          }
        },
      ),
    );
  }
}

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final DeleteContactCallback deleteContact;

  const ContactListTile({
    Key? key,
    required this.contact,
    required this.deleteContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      trailing: IconButton(
        onPressed: () async {
          final shouldDeleteContact =
              await showDeleteContactConfirmDialog(context);
          if (shouldDeleteContact) {
            deleteContact(contact);
          }
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
