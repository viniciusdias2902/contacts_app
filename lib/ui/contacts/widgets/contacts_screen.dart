import 'dart:convert';

import 'package:contacts_app/domain/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsState();
}

class _ContactsState extends State<ContactsScreen> {
  List<Contact> contacts = [];

  Future<void> fetchContacts() async {
    final url = Uri.parse(
      'https://685cf7cd769de2bf085eaec7.mockapi.io/contacts/contact',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        setState(() {
          contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
        });
      } else {
        throw Exception(
          'Erro ao carregar contatos (código ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<void> deleteContact(String id) async {
    final url = Uri.parse(
      'https://685cf7cd769de2bf085eaec7.mockapi.io/contacts/contact/$id',
    );

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          contacts.removeWhere((contact) => contact.id == id);
        });
      } else {
        throw Exception('Erro ao deletar contato');
      }
    } catch (e) {
      throw Exception('Erro na requisição de deletar: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agenda'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Dismissible(
                  key: Key(contact.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    deleteContact(contact.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${contact.name} deletado')),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.avatar),
                    ),
                    title: Text(contact.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.email),
                        Text(contact.phoneNumber),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
