import 'package:contacts_app/ui/contacts/viewmodel/contact_view_model.dart';
import 'package:contacts_app/ui/contacts/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactViewModel()..load(),
      child: Consumer<ContactViewModel>(
        builder: (ctx, vm, _) => Scaffold(
          appBar: AppBar(title: Text('Agenda')),
          body: vm.isLoading
              ? Center(child: CircularProgressIndicator())
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
        ),
      ),
    );
  }
}
