import 'package:flutter/material.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'courses_page.dart';

class AnswersHubPage extends StatelessWidget {
  const AnswersHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final pages = <_HubEntry>[
      _HubEntry('Accueil', 'TP1', Icons.home_outlined,
          (_) => const HomePage()),
      _HubEntry('Profil', 'TP2', Icons.person_outline,
          (_) => const ProfilePage()),
      _HubEntry('Mes cours', 'TP3', Icons.menu_book_outlined,
          (_) => const CoursesPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Réponses & pages du projet')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: pages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final p = pages[i];
            return Card(
              elevation: 0,
              color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(p.icon, color: colors.primary),
                title: Text(p.title),
                subtitle: Text(p.subtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: p.builder),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HubEntry {
  const _HubEntry(this.title, this.subtitle, this.icon, this.builder);
  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
}