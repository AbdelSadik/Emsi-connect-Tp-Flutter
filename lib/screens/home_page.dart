import 'package:flutter/material.dart';

/// Page d'accueil de l'application EMSI Connect (TP1).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Couleur principale de l'application (travail complémentaire).
  static const Color primaryColor = Color(0xFF1B8A3C);

  @override
  Widget build(BuildContext context) {
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

              // ----------------------------- Partie 5 : rubriques (2 x 2)
              // Ligne 1
              const Row(
                children: [
                  Expanded(
                    child: _RubriqueCard(
                      icon: Icons.menu_book,
                      label: 'Mes cours',
                    ),
                  ),
                  SizedBox(width: 12), // espace entre les colonnes
                  Expanded(
                    child: _RubriqueCard(
                      icon: Icons.calendar_month,
                      label: 'Planning',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // espace entre les lignes
              // Ligne 2
              const Row(
                children: [
                  Expanded(
                    child: _RubriqueCard(
                      icon: Icons.person,
                      label: 'Mon profil',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _RubriqueCard(
                      icon: Icons.task_alt,
                      label: 'Mes tâches',
                    ),
                  ),
                ],
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
/// (Pas de navigation pour l'instant : elle sera ajoutée aux prochains TP.)
class _RubriqueCard extends StatelessWidget {
  const _RubriqueCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // ≥ 12 px autour du contenu
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // bleu très clair
        borderRadius: BorderRadius.circular(12), // coins arrondis
        border: Border.all(color: Colors.blue.shade100), // bordure bleu clair
      ),
      child: Column(
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
    );
  }
}
