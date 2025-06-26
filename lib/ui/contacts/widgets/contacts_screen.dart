import 'package:contacts_app/ui/contacts/viewmodel/contact_view_model.dart';
import 'package:contacts_app/ui/contacts/widgets/contact_tile.dart';
import 'package:contacts_app/ui/contacts/widgets/contacts_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      context.read<ContactViewModel>().load();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ContactViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactFormScreen()),
          );
          await context.read<ContactViewModel>().load(); // <-- recarrega!
        },
        child: const Icon(Icons.add),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.contacts.length,
              itemBuilder: (_, i) {
                final contact = vm.contacts[i];
                return ContactTile(
                  contact: contact,
                  onDelete: () => vm.delete(contact.id),
                );
              },
            ),
    );
  }
}
