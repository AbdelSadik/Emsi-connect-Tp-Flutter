import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emsi_connect/main.dart';

void main() {
  testWidgets('La page d\'accueil affiche les 4 rubriques', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('EMSI Connect'), findsOneWidget);
    expect(find.text('Bienvenue sur EMSI Connect'), findsOneWidget);
    expect(find.text('Mes cours'), findsOneWidget);
    expect(find.text('Planning'), findsOneWidget);
    expect(find.text('Mon profil'), findsOneWidget);
    expect(find.text('Mes tâches'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
