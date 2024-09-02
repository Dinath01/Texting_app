import 'package:flutter/material.dart';
import 'package:text_app/pages/login_page.dart';
import 'package:text_app/pages/register_page.dart';
import 'package:text_app/services/auth/login_or_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
    );
  }
}
