import 'package:contacts_app/data/repository/contact_repository.dart';
import 'package:contacts_app/domain/contact.dart';
import 'package:flutter/material.dart';

class ContactViewModel extends ChangeNotifier {
  final repo = ContactRepository();

  List<Contact> contacts = [];
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    contacts = await repo.getContacts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await repo.removeContact(id);
    contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
