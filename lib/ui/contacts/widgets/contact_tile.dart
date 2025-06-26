import 'package:contacts_app/domain/contact.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: Key(contact.id),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
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
      ),
    );
  }
}
