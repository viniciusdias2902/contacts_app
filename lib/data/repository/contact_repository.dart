import 'package:contacts_app/data/service/contact_service.dart';
import 'package:contacts_app/domain/contact.dart';

class ContactRepository {
  final ContactService _service = ContactService();

  Future<List<Contact>> getContacts() => _service.fetchAll();
  Future<void> removeContact(String id) => _service.delete(id);
  Future<void> addContact(Contact contact) => _service.create(contact);
  Future<void> updateContact(Contact contact) => _service.update(contact);
}
