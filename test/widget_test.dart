import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emsi_connect/main.dart';
import 'package:emsi_connect/screens/courses_page.dart';
import 'package:emsi_connect/screens/home_page.dart';
import 'package:emsi_connect/screens/profile_page.dart';
import 'package:emsi_connect/screens/register_page.dart';
import 'package:emsi_connect/theme/app_theme.dart';
import 'package:emsi_connect/utils/validators.dart';

/// Page seule, avec le thème global (comme dans l'application).
Widget _wrap(Widget page) => MaterialApp(theme: AppTheme.light(), home: page);

/// Simule un écran de la taille voulue (en pixels logiques).
void _setScreen(WidgetTester tester, double width, double height) {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

/// Fait défiler jusqu'au bouton, puis appuie dessus.
Future<void> _tapText(WidgetTester tester, String text) async {
  final finder = find.text(text);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _field(String label) => find.widgetWithText(TextFormField, label);

EditableText _editable(WidgetTester tester, String label) =>
    tester.widget<EditableText>(
      find.descendant(of: _field(label), matching: find.byType(EditableText)),
    );

void main() {
  setUp(() => themeModeNotifier.value = ThemeMode.light);

  group('Validators', () {
    test('email', () {
      expect(Validators.email(''), 'Email obligatoire');
      expect(Validators.email('   '), 'Email obligatoire');
      expect(Validators.email('sara.example.com'), 'Email invalide');
      expect(Validators.email('sara@example.com'), isNull);
    });

    test('mot de passe', () {
      expect(Validators.password(''), 'Mot de passe obligatoire');
      expect(Validators.password('abcd'), 'Au moins 8 caractères');
      expect(Validators.password('abcd1234'), isNull);
    });

    test('confirmation', () {
      expect(Validators.confirmation('', 'abcd1234'), isNotNull);
      expect(Validators.confirmation('autre', 'abcd1234'), isNotNull);
      expect(Validators.confirmation('abcd1234', 'abcd1234'), isNull);
    });

    test('téléphone facultatif', () {
      expect(Validators.optionalPhone(''), isNull);
      expect(Validators.optionalPhone('0612345678'), isNull);
      expect(Validators.optionalPhone('+212 612345678'), isNull);
      expect(Validators.optionalPhone('12345'), isNotNull);
    });
  });

  group('Connexion', () {
    testWidgets('champs vides : messages obligatoires', (tester) async {
      await tester.pumpWidget(const MyApp());
      await _tapText(tester, 'Vérifier la saisie');

      expect(find.text('Email obligatoire'), findsOneWidget);
      expect(find.text('Mot de passe obligatoire'), findsOneWidget);
    });

    testWidgets('email sans @ et mot de passe de 4 caractères', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.enterText(_field('Adresse email'), 'sara.example.com');
      await tester.enterText(_field('Mot de passe'), 'abcd');
      await _tapText(tester, 'Vérifier la saisie');

      expect(find.text('Email invalide'), findsOneWidget);
      expect(find.text('Au moins 8 caractères'), findsOneWidget);
    });

    testWidgets('saisie valide : SnackBar avec email, sans mot de passe', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.enterText(_field('Adresse email'), 'sara@example.com');
      await tester.enterText(_field('Mot de passe'), 'motdepasse123');
      await _tapText(tester, 'Vérifier la saisie');

      expect(find.textContaining('Saisie valide'), findsOneWidget);
      expect(find.textContaining('sara@example.com'), findsOneWidget);
      expect(find.textContaining('motdepasse123'), findsNothing);
    });

    testWidgets('bouton œil : visible puis masqué', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(_editable(tester, 'Mot de passe').obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();
      expect(_editable(tester, 'Mot de passe').obscureText, isFalse);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(_editable(tester, 'Mot de passe').obscureText, isTrue);
    });

    testWidgets('lien vers Inscription', (tester) async {
      await tester.pumpWidget(const MyApp());
      await _tapText(tester, 'Pas encore de compte ? Créer un compte');

      expect(find.text('Inscription'), findsOneWidget);
      expect(find.text('Créer mon compte'), findsOneWidget);
    });

    testWidgets('écran étroit (320 px) : aucun débordement', (tester) async {
      _setScreen(tester, 320, 568);
      await tester.pumpWidget(const MyApp());
      expect(tester.takeException(), isNull);
    });

    testWidgets('bascule clair / sombre', (tester) async {
      await tester.pumpWidget(const MyApp());
      Brightness current() =>
          Theme.of(tester.element(find.byType(Scaffold))).brightness;
      expect(current(), Brightness.light);

      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pumpAndSettle();
      expect(current(), Brightness.dark);
    });
  });

  group('Inscription', () {
    testWidgets('mots de passe différents : message de non-concordance', (
      tester,
    ) async {
      _setScreen(tester, 800, 1600);
      await tester.pumpWidget(_wrap(const RegisterPage()));

      await tester.enterText(_field('Nom complet'), 'Sara El Amrani');
      await tester.enterText(_field('Adresse email'), 'sara@example.com');
      await tester.enterText(_field('Mot de passe'), 'motdepasse123');
      await tester.enterText(
        _field('Confirmer le mot de passe'),
        'motdepasse999',
      );
      await _tapText(tester, 'Créer mon compte');

      expect(
        find.text('Les mots de passe ne correspondent pas'),
        findsOneWidget,
      );
      expect(find.text('Formulaire valide — compte non créé'), findsNothing);
    });

    testWidgets('tout est valide : compte non créé', (tester) async {
      _setScreen(tester, 800, 1600);
      await tester.pumpWidget(_wrap(const RegisterPage()));

      await tester.enterText(_field('Nom complet'), 'Sara El Amrani');
      await tester.enterText(_field('Adresse email'), 'sara@example.com');
      await tester.enterText(_field('Mot de passe'), 'motdepasse123');
      await tester.enterText(
        _field('Confirmer le mot de passe'),
        'motdepasse123',
      );
      await _tapText(tester, 'Créer mon compte');

      expect(find.text('Formulaire valide — compte non créé'), findsOneWidget);
    });

    testWidgets('écran étroit (320 px) : aucun débordement', (tester) async {
      _setScreen(tester, 320, 568);
      await tester.pumpWidget(_wrap(const RegisterPage()));
      expect(tester.takeException(), isNull);
    });
  });

  group('Pages des TP précédents (avec le thème Material 3)', () {
    testWidgets('HomePage : 4 rubriques dans la grille', (tester) async {
      await tester.pumpWidget(_wrap(const HomePage()));

      expect(find.text('EMSI Connect'), findsOneWidget);
      expect(find.text('Mes cours'), findsOneWidget);
      expect(find.text('Planning'), findsOneWidget);
      expect(find.text('Mon profil'), findsOneWidget);
      expect(find.text('Mes tâches'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('HomePage : 2 colonnes sur téléphone, sans débordement', (
      tester,
    ) async {
      _setScreen(tester, 320, 640);
      await tester.pumpWidget(_wrap(const HomePage()));

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
      expect(tester.takeException(), isNull);
    });

    testWidgets('HomePage : 3 colonnes sur tablette', (tester) async {
      _setScreen(tester, 900, 1200);
      await tester.pumpWidget(_wrap(const HomePage()));

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
    });

    testWidgets('ProfilePage', (tester) async {
      await tester.pumpWidget(_wrap(const ProfilePage()));

      expect(find.text('Mon profil'), findsOneWidget);
      expect(find.text('Nom : Sara El Amrani'), findsOneWidget);
    });

    testWidgets('CoursesPage', (tester) async {
      await tester.pumpWidget(_wrap(const CoursesPage()));

      expect(find.text('Mes cours'), findsOneWidget);
      expect(find.text('Modules du semestre'), findsOneWidget);
    });
  });
}
