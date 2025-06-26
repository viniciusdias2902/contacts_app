import 'dart:convert';
import 'package:contacts_app/domain/contact.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ContactService {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  Future<List<Contact>> fetchAll() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((json) => Contact.fromJson(json))
          .toList();
    }
    throw Exception('Erro ao carregar contatos');
  }

  Future<void> delete(String id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 200) throw Exception('Erro ao deletar');
  }

  Future<void> create(Contact contact) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': contact.name,
        'avatar': contact.avatar,
        'phoneNumber': contact.phoneNumber,
        'email': contact.email,
        'cityName': contact.cityName,
      }),
    );
    if (res.statusCode != 201) throw Exception('Erro ao criar contato');
  }

  Future<void> update(Contact contact) async {
    final res = await http.put(
      Uri.parse('$baseUrl/${contact.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': contact.name,
        'avatar': contact.avatar,
        'phoneNumber': contact.phoneNumber,
        'email': contact.email,
        'cityName': contact.cityName,
      }),
    );
    if (res.statusCode != 200) throw Exception('Erro ao atualizar contato');
  }
}
