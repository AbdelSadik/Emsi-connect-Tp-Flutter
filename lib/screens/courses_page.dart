import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  static const Color primaryColor = Color(0xFF1B8A3C);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modules = [
      {
        'nom': 'Développement Multi-Plateforme',
        'enseignant': 'Mme Aouraghe',
        'heures': 32,
        'icone': Icons.menu_book,
      },
      {
        'nom': 'Bases de données avancées',
        'enseignant': 'M. Benali',
        'heures': 28,
        'icone': Icons.storage,
      },
      {
        'nom': 'Réseaux informatiques',
        'enseignant': 'M. Exemple',
        'heures': 24,
        'icone': Icons.network_check,
      },
      {
        'nom': 'Intelligence artificielle',
        'enseignant': 'Mme Idrissi',
        'heures': 30,
        'icone': Icons.psychology,
      },
      {
        'nom': 'Cybersécurité',
        'enseignant': 'M. Tazi',
        'heures': 26,
        'icone': Icons.security,
      },
      {
        'nom': 'Gestion de projet',
        'enseignant': 'Mme Alaoui',
        'heures': 20,
        'icone': Icons.computer,
      },
      {
        'nom': 'Architecture logicielle et conception orientée objet avancée',
        'enseignant': 'M. Chraibi',
        'heures': 36,
        'icone': Icons.computer,
      },
      {
        'nom': 'Anglais technique',
        'enseignant': 'Mme Smith',
        'heures': 18,
        'icone': Icons.menu_book,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes cours'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Modules du semestre',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final module = modules[index];
                final String nom = module['nom'] as String;
                final String enseignant = module['enseignant'] as String;
                final int heures = module['heures'] as int;
                final IconData icone = module['icone'] as IconData;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icone, color: primaryColor),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          child: Text('${index + 1}'),
                        ),
                      ],
                    ),
                    title: Text(
                      nom,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Enseignant : $enseignant\n$heures heures'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Module sélectionné : $nom')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
