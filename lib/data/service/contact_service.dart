import 'dart:convert';

import 'package:contacts_app/domain/contact.dart';
import 'package:http/http.dart' as http;

class ContactService {
  final base = 'https://685cf7cd769de2bf085eaec7.mockapi.io/contacts/contact';

  Future<List<Contact>> fetchAll() async {
    final res = await http.get(Uri.parse(base));
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((j) => Contact.fromJson(j))
          .toList();
    }
    throw Exception('Erro ao carregar');
  }

  Future<void> delete(String id) async {
    final res = await http.delete(Uri.parse('$base/$id'));
    if (res.statusCode != 200) throw Exception('Erro ao deletar');
  }
}
