// Importe Material (MaterialApp, widgets de base).
import 'package:flutter/material.dart';
// Les pages des TP précédents sont conservées (le TP interdit de les supprimer).
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
// TP3 : la nouvelle page « Mes cours ».
import 'screens/courses_page.dart';

// Point d'entrée de l'application : Flutter commence ici.
void main() {
  // runApp démarre l'app avec MyApp comme widget racine.
  runApp(const MyApp());
}

// Widget racine de l'application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp : configure l'application (thème, titre, page de départ...).
    return MaterialApp(
      title: 'EMSI Connect', // nom de l'app (utilisé par le système)
      debugShowCheckedModeBanner: false, // cache le bandeau « DEBUG »
      // TP3 : affichage provisoire de CoursesPage.
      // Pour revenir aux pages précédentes : const HomePage() ou const ProfilePage().
      home: const CoursesPage(),
    );
  }
}
