import 'package:contacts_app/domain/contact.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const ContactTile({Key? key, required this.contact, required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${contact.name} deletado')));
      },
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(contact.avatar)),
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(contact.email), Text(contact.phoneNumber)],
        ),
        isThreeLine: true,
      ),
    );
  }
}
