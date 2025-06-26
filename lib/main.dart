import 'package:contacts_app/ui/contacts/widgets/contacts_screen.dart';
import 'package:contacts_app/ui/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.light, home: ContactsScreen());
  }
}
