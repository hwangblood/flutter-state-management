import 'package:flutter/material.dart';
import 'package:vanillacontacts_course/contact_book.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (BuildContext context, value, Widget? child) {
          final contacts = value;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = contacts[index];
              return Dismissible(
                key: ValueKey(contact.id),
                onDismissed: (direction) {
                  ContactBook().remove(contact: contact);
                },
                child: Material(
                  color: Colors.white,
                  elevation: 6,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/new-contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
