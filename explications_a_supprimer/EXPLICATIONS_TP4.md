# TP4 – Réponses + explications (fichier d'étude, à supprimer avant la remise)

> Le fichier propre à rendre est `REPONSES_TP4.md`. Ici : pour chaque point, la réponse courte, puis l'explication, puis comment c'est fait dans ton code.

---
## 1. TextField vs TextFormField

**Réponse :** `TextFormField` = `TextField` + intégration à un `Form` (donc `validator`).

**Explication :** `TextFormField` est en réalité un `FormField` qui *contient* un `TextField`. Le `Form` parent sait donc le trouver, l'interroger et lui demander « es-tu valide ? ».
- `TextField` seul : parfait pour une barre de recherche (rien à valider).
- `TextFormField` : dès qu'on veut des messages d'erreur sous le champ.

**Dans ton code :** les 2 pages utilisent `TextFormField` avec `validator: Validators.email` etc.

---
## 2. Rôle de Form + 3. Pourquoi la GlobalKey ?

**Réponse :** `Form` regroupe les champs ; la `GlobalKey<FormState>` permet de lancer `validate()` depuis l'extérieur.

**Explication :** imagine un jury qui doit vérifier 4 copies. `Form` est le jury, `validate()` est l'ordre « vérifiez tout », et la clé est le numéro de téléphone du jury : le bouton n'est pas dans le `Form` (ou pas dans le même widget), il a besoin d'un moyen de l'appeler.

```dart
final _formKey = GlobalKey<FormState>();
Form(key: _formKey, child: ...);          // on branche la clé
_formKey.currentState!.validate();        // on s'en sert ailleurs
```
`validate()` appelle le `validator` de **chaque** champ, affiche les erreurs, et retourne `true` seulement si tout est valide.

**Piège :** `currentState!` plante si la clé n'est attachée à aucun `Form` (d'où l'importance de `key: _formKey`).

---
## 4. Que retourne un validator ?

**Réponse :** `null` si valide, sinon le texte de l'erreur.

**Explication :** c'est une convention un peu « à l'envers » : *pas de message = pas de problème*.
```dart
String? email(String? value) {
  if (value == null || value.isEmpty) return 'Email obligatoire'; // invalide
  return null;                                                    // valide
}
```
Le type `String?` (nullable) existe pour ça. Les règles sont testées dans l'ordre : on s'arrête à la première erreur (d'abord « vide », ensuite « invalide »).

---
## 5. Pourquoi emailAddress ne valide-t-il pas ?

**Réponse :** il ne change que le clavier.

**Explication :** `keyboardType` = confort de saisie (le clavier mobile affiche `@` et `.`). Un clavier physique, un copier-coller ou un clavier tiers contournent tout ça. La validité d'une donnée se vérifie **toujours** dans le code (`validator`). Et même une regex ne prouve pas qu'une adresse *existe* : seul un email de confirmation le prouve.

---
## 6. TextEditingController

**Réponse :** lire/modifier le texte d'un champ ; `controller.text`.

**Explication :** par défaut, le texte appartient au champ et tu n'y as pas accès. Le contrôleur est une « télécommande » : `controller.text` lit, `controller.text = 'abc'` écrit, `controller.clear()` vide.
```dart
final email = _emailController.text.trim(); // trim : retire les espaces autour
```
Il faut le brancher : `TextFormField(controller: _emailController, ...)`.

**Piège :** le créer dans `build()` → un nouveau contrôleur à chaque reconstruction, donc le texte saisi serait perdu. Il vit dans le `State`.

---
## 7. Pourquoi dispose() ?

**Réponse :** pour libérer les ressources et éviter les fuites de mémoire.

**Explication :** un contrôleur est un objet qui garde des *listeners* (écouteurs). Quand la page disparaît, Flutter détruit le `State` mais pas ces objets : c'est à toi de dire « j'ai fini ».
```dart
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();      // toujours en dernier
}
```
Règle : *tout ce que tu crées dans `initState` / un champ du State (contrôleur, animation, timer, stream) se libère dans `dispose`.* Dans `RegisterPage` il y a 6 contrôleurs, donc 6 `dispose()`.

---
## 8. Stateless vs Stateful

**Réponse :** Stateful quand il y a un état qui change ou des ressources à libérer.

**Explication :** un `StatelessWidget` est une photo : même données → même image. Un `StatefulWidget` a un `State` qui survit aux reconstructions et peut changer.

| | Stateless | Stateful |
|---|---|---|
| Exemple dans le TP | HomePage, ProfilePage, CoursesPage | LoginPage, RegisterPage |
| Données qui changent | non | `_showPassword`, `_autoMode` |
| Ressources | non | contrôleurs (+ `dispose`) |

**Structure Stateful :** 2 classes. `LoginPage` (le widget, immuable) crée `_LoginPageState` (l'état, mutable) via `createState()`.

---
## 9. Rôle de setState

**Réponse :** change la variable et déclenche la reconstruction.

**Explication :**
```dart
onPressed: () => setState(() => _showPassword = !_showPassword),
```
1. la valeur est inversée ;
2. Flutter rappelle `build()` ;
3. `obscureText: !_showPassword` et l'icône sont recalculés.

Sans `setState`, la variable change en mémoire mais l'écran ne se redessine pas.
**Piège :** ne jamais mettre `setState` à l'intérieur de `build()` (boucle infinie).

---
## 10. Pas de mot de passe dans la console

**Réponse :** la console, les logs et les captures peuvent être lus par d'autres.

**Explication :** les logs sont conservés, copiés dans des tickets de bug, envoyés aux outils de crash reporting. Un mot de passe écrit dedans fuit. Règle : *on n'affiche jamais un secret*, et dans une vraie appli on ne le stocke pas non plus en clair. C'est pourquoi le `SnackBar` affiche seulement l'email.

---
## 11. Validation locale ≠ compte créé

**Réponse :** elle vérifie la forme, pas l'existence ; il faut un serveur.

**Explication :** ton `validate()` répond « le texte a la bonne forme ». Il ne répond ni « cet email est-il déjà pris ? », ni « ce mot de passe est-il correct ? », ni ne stocke quoi que ce soit : tout cela exige une base de données et un service d'authentification côté serveur (Firebase / Supabase aux prochains TP). D'où le message volontaire : « compte non créé ».

---
## 12. ThemeData et ColorScheme.fromSeed

**Réponse :** `ThemeData` = réglages visuels globaux ; `fromSeed` = palette générée depuis une couleur.

**Explication :** au lieu de choisir à la main 30 couleurs, tu donnes **une** couleur (`seedColor`) et Material 3 calcule `primary`, `onPrimary`, `secondary`, `surface`, `error`, `primaryContainer`… avec des contrastes lisibles, en clair **et** en sombre (`brightness`).

```dart
ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark)
```
`ThemeData` range ça avec les styles de composants : `inputDecorationTheme`, `elevatedButtonTheme`, `appBarTheme`.

**Dans ton code :** `lib/theme/app_theme.dart`, utilisé une seule fois dans `main.dart`.

**Partie 5 (17) – indigo puis vert :** change seulement `seedColor`. AppBar, bouton, bordure du champ sélectionné, icône et titre de la page de connexion changent de teinte tous ensemble. Preuve que le thème centralise tout.

**Partie 5 (18) – personnalisation par thème :** exemple, la bordure arrondie : une ligne dans `inputDecorationTheme` s'applique aux 6 champs ; sans thème il faudrait écrire `border: OutlineInputBorder(...)` six fois.

**Partie 5 (16) – pas de seconde MaterialApp :** une `MaterialApp` crée un thème, un `Navigator`, etc. Si chaque page en avait une, elles ne partageraient pas le thème et la navigation casserait.

---
## 13. Couleur codée en dur vs Theme.of(context)

**Réponse :** la 2ᵉ s'adapte au thème, pas la 1ʳᵉ.

**Explication :**
```dart
color: Colors.blue.shade50                    // figé
color: Theme.of(context).colorScheme.primary  // suit le thème (clair/sombre, autre seed)
```
**Dans ce projet :** les pages de TP1-3 ont des couleurs codées en dur (`Colors.blue.shade50`, `primaryColor`). Si on passe en mode sombre, un texte noir sur fond bleu très clair reste lisible, mais le reste de la page ne suit pas. C'est exactement ce que la question veut te faire comprendre. Les pages TP4 (Login/Register) utilisent `colors.primary`, `colors.onSurfaceVariant` : elles suivent le thème.

---
## 14. ConstrainedBox(maxWidth: 420) + Partie 6

**Réponse :** limite la largeur max du formulaire.

**Explication :** un `maxWidth` est un **plafond**, pas une largeur imposée. Téléphone 320 px → le formulaire prend 320 − 32 (padding). Ordinateur 1400 px → il s'arrête à 420 et `Center` le place au milieu.

L'empilement de la Partie 6 :
```
Scaffold
 └ SafeArea                    // évite encoche / barre système
    └ SingleChildScrollView    // défile quand le clavier réduit la hauteur
       └ Center                // centre horizontalement
          └ ConstrainedBox     // largeur ≤ 420
             └ Form → Column
```
Chacun résout un problème distinct : sans `SingleChildScrollView` le clavier provoquerait un « BOTTOM OVERFLOWED » (cf. TP3 : `Column` ne défile pas).

**Les 2 phrases demandées (23) :** *Sans limite, les champs s'étireraient sur toute la largeur d'un grand écran, ce qui est peu lisible et peu pratique. `ConstrainedBox(maxWidth: 420)` garde un formulaire de largeur confortable et centré, sans forcer 420 px sur un petit téléphone.*

---
## 15. MediaQuery vs LayoutBuilder

**Réponse :** MediaQuery = tout l'écran ; LayoutBuilder = l'espace du parent.

**Explication :** si ta grille est dans une colonne latérale de 300 px sur un écran de 1200 px, `MediaQuery.of(context).size.width` répond 1200 (faux pour ta grille) alors que `LayoutBuilder` répond 300 (juste).
```dart
LayoutBuilder(builder: (context, constraints) {
  final columns = constraints.maxWidth < 600 ? 2 : 3;   // décision locale
  ...
})
```
`MediaQuery` reste utile pour le global : taille de police système, orientation, hauteur du clavier (`viewInsets`).

---
## 16. ListView vs GridView + Partie 7

**Réponse :** ListView = 1 colonne défilante ; GridView = grille défilante.

**Explication :** les deux défilent et ont un `.builder` pour les longues listes.
- **ListView** : éléments pleine largeur (liste de cours) → `CoursesPage`.
- **GridView** : cartes en colonnes (rubriques, photos).

**HomePage (24) :** les 2 `Row` du TP1 sont remplacées par une `GridView.count`. Avantage : changer le nombre de colonnes = changer **un nombre** (`crossAxisCount`), alors que les `Row` obligent à réécrire la structure.

Pourquoi `shrinkWrap: true` + `NeverScrollableScrollPhysics()` ici ? La page est **déjà** dans un `SingleChildScrollView`. Une grille dans un scroll → hauteur infinie → erreur. `shrinkWrap` la fait prendre juste sa hauteur, et `NeverScrollable` évite deux zones de défilement imbriquées. (Dans un `Scaffold` seul, on ne les mettrait pas.)

**Téléphone vs tablette (25) :** 2 colonnes sous 600 px, 3 au-delà. À 3 colonnes, 4 éléments laissent une case vide sur la 2ᵉ ligne : c'est le genre de détail qu'on observe en testant. J'ai aussi plafonné la grille à 720 px pour que les cartes ne deviennent pas énormes.

---
## Les parties de code, étape par étape

**Partie 1-2 :** `TextFormField` + `Form` + `validator`.
Teste mentalement : email `''` → « Email obligatoire » ; `abc` → « Email invalide » ; mot de passe `abcd` → « Au moins 8 caractères ».

**Partie 3 :** passage en Stateful, contrôleurs, `dispose`, œil.

**Partie 4 :** la confirmation compare à `_passwordController.text` :
```dart
validator: (value) => Validators.confirmation(value, _passwordController.text),
```
Comme `_passwordController` appartient au State, la comparaison est toujours faite avec la saisie actuelle.

**Mon ajout `_autoMode` :** au premier échec, on passe à `AutovalidateMode.onUserInteraction` : les erreurs disparaissent dès que l'utilisateur corrige, sans attendre un nouvel appui sur le bouton.

**Fichier `validators.dart` (bonus) :** les règles sont écrites une fois et réutilisées dans Login et Register. Si un jour la règle passe à 10 caractères, un seul endroit à modifier.

**Bascule clair/sombre (bonus) :**
```
ThemeToggleButton → themeModeNotifier.value = dark
MaterialApp (ValueListenableBuilder) → themeMode: dark
```
Aucune page n'est modifiée : elles lisent le thème via `Theme.of(context)`.

**Compteur de caractères (bonus) :** `maxLength: 200` suffit, Flutter affiche « 0/200 » et bloque la saisie au-delà.

---
## Comment je me suis assuré que ça marche
Je n'ai pas pu lancer Flutter dans mon environnement. J'ai vérifié la syntaxe avec le formateur Dart et j'ai écrit des tests (`test/widget_test.dart`) qui rejouent la campagne de tests. À toi de lancer `flutter test` puis `flutter run`.
