import 'package:flutter/material.dart';

/// Mode de thème courant (clair / sombre).
/// Un seul ValueNotifier suffit : MaterialApp l'écoute (voir main.dart),
/// donc toutes les pages changent de thème sans être modifiées une à une.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.light,
);

/// Thème Material 3 global de EMSI Connect (déclaré une seule fois).
class AppTheme {
  AppTheme._();

  /// Couleur de départ du ColorScheme.
  /// Test du TP : Colors.indigo puis vert. On garde le vert EMSI.
  static const Color seedColor = Color(0xFF1B8A3C);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    // fromSeed génère toute une palette cohérente (primary, secondary,
    // surface, error...) à partir de la seule couleur de départ.
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      // Tous les champs de texte auront cette bordure (plus de répétition).
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Tous les ElevatedButton auront ce style.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Barre supérieure cohérente avec la couleur principale.
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        centerTitle: true,
      ),
    );
  }
}
