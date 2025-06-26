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
        contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception(
          'Erro ao carregar contatos (código ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(title: Text('Agenda'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: fetchContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.avatar),
                  ),
                  title: Text(contact.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(contact.email), Text(contact.phoneNumber)],
                  ),
                  isThreeLine: true,
                );
              },
            );
          }
        },
      ),
    );
  }
}
