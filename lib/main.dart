import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart'; // ← ajout

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMSI Connect',
      debugShowCheckedModeBanner: false,
       home: const ProfilePage(),
    );
  }
}