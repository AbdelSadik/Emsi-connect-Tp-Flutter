// Importe Material (MaterialApp, widgets de base).
import 'package:flutter/material.dart';

import 'screens/login_page.dart';
import 'theme/app_theme.dart';

// Pour tester une autre page (TP1 à TP3), ajouter l'import voulu :
//   import 'screens/home_page.dart';      -> const HomePage()
//   import 'screens/profile_page.dart';   -> const ProfilePage()
//   import 'screens/courses_page.dart';   -> const CoursesPage()
// puis remplacer `home:` ci-dessous (et le remettre sur LoginPage ensuite).

// Point d'entrée de l'application : Flutter commence ici.
void main() {
  runApp(const MyApp());
}

// Widget racine de l'application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Une SEULE MaterialApp pour toute l'application : le thème est déclaré
    // ici, les pages ne créent jamais leur propre MaterialApp.
    // ValueListenableBuilder reconstruit l'app quand le mode clair/sombre change.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'EMSI Connect',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          home: const LoginPage(),
        );
      },
    );
  }
}
