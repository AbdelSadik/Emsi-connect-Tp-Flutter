import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Bouton clair/sombre à mettre dans une AppBar.
/// Il modifie themeModeNotifier : MaterialApp (main.dart) fait le reste.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return IconButton(
          tooltip: isDark ? 'Thème clair' : 'Thème sombre',
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            themeModeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
          },
        );
      },
    );
  }
}
