import 'package:flutter/material.dart';

/// InheritedWidget pour exposer toggleTheme() à tout descendant.
class ThemeController extends InheritedWidget {
  const ThemeController({
    super.key,
    required this.toggleTheme,
    required super.child,
  });

  final VoidCallback toggleTheme;

  static ThemeController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeController>();
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      oldWidget.toggleTheme != toggleTheme;
}

/// Bouton bonus : bascule thème clair / sombre sans toucher aux pages.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.maybeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Thème clair' : 'Thème sombre',
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      ),
      onPressed: controller?.toggleTheme,
    );
  }
}