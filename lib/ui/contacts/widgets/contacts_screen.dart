import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});
  @override
  State<ContactsScreen> createState() => _ContactsState();
}

class _ContactsState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(title: Text('Agenda'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
