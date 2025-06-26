import 'package:contacts_app/ui/contacts/viewmodel/contact_view_model.dart';
import 'package:contacts_app/ui/contacts/widgets/contacts_screen.dart';
import 'package:contacts_app/ui/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ContactViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: ContactsScreen(),
      ),
    );
  }
}
