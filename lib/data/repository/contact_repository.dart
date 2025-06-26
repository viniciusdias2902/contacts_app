import 'package:contacts_app/data/service/contact_service.dart';
import 'package:contacts_app/domain/contact.dart';

class ContactRepository {
  final service = ContactService();

  Future<List<Contact>> getContacts() => service.fetchAll();
  Future<void> removeContact(String id) => service.delete(id);
}
