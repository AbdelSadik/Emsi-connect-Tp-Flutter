import 'package:flutter/material.dart';

import 'about_page.dart';
import 'courses_page.dart';
import 'login_page.dart';
import 'multimedia_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

/// Page d'accueil de l'application EMSI Connect (TP1).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Couleur principale de l'application (travail complémentaire).
  static const Color primaryColor = Color(0xFF1B8A3C);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      // ----------------------------- Partie 3 : AppBar
      appBar: AppBar(
        title: const Text('EMSI Connect'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Complémentaire : deuxième action dans l'AppBar
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Rechercher',
            onPressed: () {
              debugPrint('Recherche ouverte');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {
              debugPrint('Notifications consultées');
            },
          ),
        ],
      ),

      // ----------------------------- TP5 : Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: colors.primary),
              accountName: const Text('Étudiant EMSI'),
              accountEmail: const Text('etudiant@emsi.ma'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colors.onPrimary,
                child: Icon(Icons.person, color: colors.primary),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Accueil'),
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: const Text('Mes cours'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CoursesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Mon profil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_media),
              title: const Text('Espace multimédia'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MultimediaPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      // ----------------------------- Partie 4 : contenu principal
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/emsi.jpg',
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenue sur EMSI Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              // Complémentaire : slogan sous le titre
              const Text(
                'Étudiez, planifiez, avancez.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Votre espace universitaire pour accéder à vos cours, '
                'votre planning et vos informations personnelles.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 32),

              // ----------------------------- TP4 Partie 7 : rubriques en GridView
              // (remplace les deux Row du TP1 : 2 colonnes sur téléphone,
              // 3 sur tablette). La page défile déjà (SingleChildScrollView) :
              // shrinkWrap + NeverScrollableScrollPhysics évitent deux scrolls imbriqués.
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth < 600 ? 2 : 3;
                    return GridView.count(
                      crossAxisCount: columns,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _RubriqueCard(
                          icon: Icons.menu_book,
                          label: 'Mes cours',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CoursesPage(),
                              ),
                            );
                          },
                        ),
                        const _RubriqueCard(
                          icon: Icons.calendar_month,
                          label: 'Planning',
                        ),
                        _RubriqueCard(
                          icon: Icons.person,
                          label: 'Mon profil',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                        ),
                        const _RubriqueCard(
                          icon: Icons.task_alt,
                          label: 'Mes tâches',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ----------------------------- Partie 6 : bouton flottant
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Ajouter',
        onPressed: () {
          debugPrint('Fonctionnalité bientôt disponible');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Bloc visuel d'une rubrique : une icône et son libellé.
/// onTap optionnel : navigation ajoutée au TP5.
class _RubriqueCard extends StatelessWidget {
  const _RubriqueCard({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16), // ≥ 12 px autour du contenu
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
