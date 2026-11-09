# TP4 – Formulaires, validation, Material 3 et interfaces adaptatives : réponses

## Questions de compréhension

**1. Différence entre `TextField` et `TextFormField` ?**
`TextField` est un champ de saisie général. `TextFormField` est un `TextField` conçu pour vivre dans un `Form` : il ajoute notamment `validator` (et `autovalidateMode`, `onSaved`).

**2. Rôle de `Form` ?**
Il regroupe plusieurs champs validables et permet de les valider (ou réinitialiser) tous en une seule fois.

**3. Pourquoi associer une `GlobalKey<FormState>` à `Form` ?**
Pour retrouver l'état du `Form` depuis n'importe quel endroit de la page (ex. un bouton) et appeler `_formKey.currentState!.validate()`.

**4. Que retourne un `validator` ?**
`null` quand la valeur est acceptée ; une chaîne de caractères (le message d'erreur) quand elle est invalide.

**5. Pourquoi `keyboardType: TextInputType.emailAddress` ne valide-t-il pas un email ?**
Il choisit seulement le clavier affiché (touche `@` accessible). Rien n'empêche de saisir n'importe quel texte, y compris au clavier physique ou par copier-coller : la validation passe par `validator`.

**6. À quoi sert `TextEditingController` ? Comment lire sa valeur ?**
À lire ou modifier le contenu d'un champ. On lit avec `controller.text` (ex. `_emailController.text.trim()`).

**7. Pourquoi libérer les contrôleurs dans `dispose()` ?**
Un contrôleur garde des écouteurs et des ressources en mémoire. Sans `dispose()`, ils restent alloués après la fermeture de la page (fuite de mémoire).

**8. `StatelessWidget` vs `StatefulWidget` dans ce TP ?**
`StatelessWidget` : rien ne change dans l'écran (HomePage, ProfilePage…). `StatefulWidget` : on a un état qui évolue (visibilité du mot de passe, mode d'auto-validation) et des ressources à gérer (contrôleurs, libérés dans `dispose()`).

**9. Rôle de `setState` pour le bouton de visibilité ?**
Il modifie `_showPassword` et demande à Flutter de reconstruire le widget (`build`) avec la nouvelle valeur ; sans lui la variable change mais l'écran reste identique.

**10. Pourquoi ne pas afficher un mot de passe dans la console ?**
La console, les journaux et les captures d'écran peuvent être lus par d'autres personnes : un mot de passe affiché en clair est compromis. On n'affiche jamais le mot de passe (ni dans `debugPrint`, ni dans un `SnackBar`).

**11. Pourquoi une validation locale ne signifie-t-elle pas qu'un compte a été créé ?**
Elle vérifie seulement la forme des données, sur l'appareil. Créer un compte nécessite un serveur (Firebase/Supabase aux prochains TP) qui enregistre l'utilisateur. D'où le message « compte non créé ».

**12. À quoi servent `ThemeData` et `ColorScheme.fromSeed` ?**
`ThemeData` regroupe les choix visuels de toute l'application (couleurs, bordures des champs, style des boutons, AppBar…), déclarés une fois dans `MaterialApp`. `ColorScheme.fromSeed` génère un jeu de couleurs harmonieux (primary, secondary, surface, error…) à partir d'une seule couleur de départ.

**13. Couleur codée en dur vs `Theme.of(context)` ?**
Une couleur codée en dur (`Colors.blue`, `Color(0xFF1B8A3C)`) est identique partout et ne suit ni un changement de thème ni le mode sombre. `Theme.of(context).colorScheme.primary` se met à jour automatiquement quand le thème change : on modifie une seule fois la couleur de départ.

**14. Fonction de `ConstrainedBox(maxWidth: 420)` ?**
Limiter la largeur maximale du formulaire à 420 px : sur grand écran il reste lisible et centré ; sur téléphone (plus étroit) il prend simplement la largeur disponible.

**15. `MediaQuery` vs `LayoutBuilder` ?**
`MediaQuery` renseigne sur la fenêtre/l'appareil entier (taille d'écran, clavier, orientation…). `LayoutBuilder` donne les contraintes du parent à l'endroit où le widget est construit : plus précis pour adapter un composant à l'espace réellement disponible.

**16. `ListView` vs `GridView` ?**
`ListView` : liste linéaire défilante (une colonne). `GridView` : grille défilante (plusieurs colonnes). Exemples : `ListView` pour la liste des cours ; `GridView` pour les rubriques de l'accueil.

## Réponses spécifiques aux parties

**Partie 5 – Test de deux couleurs de départ (indigo puis vert).**
En changeant uniquement `seedColor`, toute l'application change de teinte (AppBar, boutons, bordure des champs au focus, icônes et titres lus via `colorScheme.primary`) sans toucher aux pages. Le thème est dans `lib/theme/app_theme.dart` ; seed final : vert EMSI `0xFF1B8A3C`.

**Partie 5 – Thèmes globaux.**
`inputDecorationTheme` (bordure arrondie de tous les champs), `elevatedButtonTheme` (couleurs, hauteur 48, coins arrondis) et `appBarTheme` (couleur principale, titre centré). Les pages ne répètent plus ces réglages.

**Partie 5 – HomePage, ProfilePage, CoursesPage ?**
Elles s'affichent toujours avec le thème Material 3 (vérifié par les tests `flutter test`). Elles ont gardé leurs couleurs codées en dur, donc elles ne s'adaptent pas au mode sombre.

**Partie 6 – Pourquoi `ConstrainedBox` sur grand écran (2 phrases).**
Sans limite, les champs s'étireraient sur toute la largeur d'un ordinateur ou d'une tablette et deviendraient difficiles à lire et à viser. `ConstrainedBox(maxWidth: 420)` garde un formulaire de largeur confortable, centré, sans imposer 420 px sur un petit téléphone.

**Partie 7 – Comparaison téléphone / tablette (grille d'accueil).**
Téléphone (< 600 px) : 2 colonnes, 2 lignes de 2 rubriques, comme au TP1. Tablette (≥ 600 px) : 3 colonnes, donc 3 rubriques puis 1 seule sur la 2ᵉ ligne (4 éléments ne remplissent pas 3 colonnes). La largeur de la grille est limitée à 720 px pour éviter des cartes géantes.

**Partie 7 – `GridView` vs `ListView`, un cas d'usage de chacune.**
`ListView` affiche les éléments les uns sous les autres : liste des modules (CoursesPage). `GridView` les répartit en colonnes : rubriques de l'accueil, galerie de photos.

## Campagne de tests obligatoires

Les 6 premiers scénarios sont aussi automatisés dans `test/widget_test.dart` (`flutter test`). Cocher après essai manuel.

| Scénario | Résultat attendu | Fait |
|---|---|---|
| Email vide | « Email obligatoire » | ☐ |
| Email sans @ | « Email invalide » | ☐ |
| Mot de passe de 4 caractères | « Au moins 8 caractères » | ☐ |
| Inscription : mots de passe différents | « Les mots de passe ne correspondent pas » | ☐ |
| Tous les champs valides | SnackBar de validation locale, sans connexion | ☐ |
| Bouton œil | Mot de passe visible puis masqué | ☐ |
| Écran étroit (≈ 320 px) | Champs accessibles, sans débordement | ☐ |
| Grand écran | Formulaire centré, largeur limitée (420 px) | ☐ |

## Partie bonus réalisée

- Téléphone : clavier numérique (`TextInputType.phone`), caractères filtrés, validation `0612345678` ou `+212…` (facultatif).
- Description : `maxLength: 200` → compteur « 0/200 » automatique.
- Validation d'email réutilisable : `Validators.email` / `Validators.isValidEmail` (`lib/utils/validators.dart`).
- Bascule clair/sombre : bouton dans l'AppBar → `themeModeNotifier` → `MaterialApp(themeMode: …)`, sans modifier les pages une à une.
