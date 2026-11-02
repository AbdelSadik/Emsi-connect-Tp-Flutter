import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bandeau : Stack dans un SizedBox de hauteur définie
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 45,
                        child: Icon(Icons.person, size: 48),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Les 4 informations
              const _InfoTile(label: 'Nom', value: 'Sara El Amrani'),
              const SizedBox(height: 12),
              const _InfoTile(label: 'Filière', value: 'Informatique'),
              const SizedBox(height: 12),
              const _InfoTile(label: 'Niveau', value: 'S5'),
              const SizedBox(height: 12),
              const _InfoTile(label: 'Email', value: 'sara@example.com'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Une information présentée dans un Container avec Padding.
class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text('$label : $value', style: const TextStyle(fontSize: 16)),
    );
  }
}