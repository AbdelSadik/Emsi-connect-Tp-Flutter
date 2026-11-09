# TP1 – Réponses + explications (fichier d'étude, à supprimer avant la remise)

> Le fichier propre à rendre est `REPONSES_TP1.md`. Ici : réponse courte, puis explication détaillée avec exemples.

## Vue d'ensemble : comment une app Flutter démarre

```
main()  →  runApp(MyApp())  →  MaterialApp  →  home: HomePage  →  Scaffold  →  AppBar + body + FAB
```
Tout est **widget**, et les widgets s'emboîtent comme des poupées russes : c'est l'*arbre de widgets*.

---
## Partie 1 – Préparer le projet

### Q4. Rôle de `main.dart`
**Réponse :** point d'entrée ; `main()` appelle `runApp(MyApp())`.

**Explication :** Dart exécute toujours la fonction `main()` en premier. `runApp()` prend un widget (la racine) et l'« accroche » à l'écran. Rien ne s'affiche sans cet appel.
```dart
void main() { runApp(const MyApp()); }
```

### Q5. Pourquoi séparer `home_page.dart` de `main.dart` ?
**Réponse :** organisation, lisibilité, réutilisation.

**Explication :** si tout est dans `main.dart`, le fichier devient énorme dès le 3ᵉ écran. En pratique : `main.dart` = configuration (thème, page de départ) ; un fichier = un écran. On retrouve vite le code, on évite les conflits quand on travaille à plusieurs, et on peut réutiliser/échanger un écran sans toucher aux autres (c'est ce qu'on fait avec `home: const LoginPage()` / `HomePage()`).

---
## Partie 2 – Structure principale

### Q6. `MaterialApp` vs `Scaffold`
**Réponse :** `MaterialApp` = l'application ; `Scaffold` = un écran.

**Explication :** `MaterialApp` : **une seule fois**, tout en haut. Il porte le titre, le thème, la page de départ, la navigation. `Scaffold` : **un par écran**. C'est le « squelette » d'une page : barre du haut, corps, bouton flottant, tiroir.
```dart
MaterialApp(home: Scaffold(appBar: AppBar(...), body: ...))
```
Analogie : `MaterialApp` est le bâtiment, `Scaffold` est le plan d'une pièce.

### Q7. Pourquoi `StatelessWidget` ?
**Réponse :** la page est statique, aucun état ne change.

**Explication :** `StatelessWidget` = widget dont l'affichage dépend uniquement de ce qu'on lui passe au départ. La page d'accueil du TP1 affiche du texte, une image, 4 rubriques : rien ne varie. (On passera à `StatefulWidget` pour un formulaire : TP4.)

---
## Partie 3 – Barre supérieure

### Q4. `Icon` vs `IconButton`
**Réponse :** `Icon` = image ; `IconButton` = bouton cliquable avec icône.

**Explication :**
```dart
Icon(Icons.search)                                  // décor, ne réagit pas
IconButton(icon: Icon(Icons.search), onPressed: () {...}, tooltip: 'Rechercher')
```
`IconButton` gère la zone de toucher (48 px), l'effet d'onde au clic, le `tooltip` (accessibilité), le `onPressed`. Dans `actions: [...]` d'une AppBar, on met des `IconButton`.

---
## Partie 4 – Contenu principal

### Q7. Rôle de `Column`
**Réponse :** empile les enfants verticalement.

**Explication :** `Column(children: [A, B, C])` → A au-dessus de B au-dessus de C. Son axe principal est vertical (`mainAxisAlignment` règle la répartition verticale), son axe transversal est horizontal (`crossAxisAlignment` règle l'alignement gauche/centre/droite). `Row` = même chose à l'horizontale.

### Q8. `Padding` vs `SizedBox`
**Réponse :** `Padding` = marge autour d'un enfant ; `SizedBox` = espace/taille fixe.

**Explication :**
```dart
Padding(padding: EdgeInsets.all(24), child: Column(...))   // enveloppe un contenu
SizedBox(height: 16)                                        // espace vide entre deux widgets
SizedBox(width: 100, height: 50, child: ...)                // impose une taille
```
Règle pratique : *autour de quelque chose* → `Padding` ; *entre deux choses* → `SizedBox`.

---
## Partie 5 – Rubriques

### Q8. Pourquoi une `Row` dans une `Column` ?
**Réponse :** `Column` = lignes ; `Row` = éléments d'une ligne → grille 2 × 2.

**Explication :** Flutter n'a pas de « tableau » de base : on l'obtient en imbriquant. `Column` empile 2 `Row` ; chaque `Row` place 2 cartes côte à côte. (TP4 : on remplace cette construction par `GridView.count`, plus simple quand le nombre de colonnes change.)

---
## Partie 6 – Bouton flottant

### Q3. À quoi sert `onPressed` ?
**Réponse :** c'est la fonction exécutée à l'appui ; `null` = bouton désactivé.

**Explication :** on passe une fonction **sans l'appeler** : `onPressed: () { debugPrint('...'); }`. Flutter la garde et l'exécute au bon moment (ce qu'on appelle un *callback*). `onPressed: null` grise le bouton automatiquement.

### Q4. Pourquoi `floatingActionButton` dans `Scaffold` ?
**Réponse :** `Scaffold` gère le placement Material.

**Explication :** le `Scaffold` sait placer le bouton en bas à droite, au-dessus du contenu, et le décale pour laisser passer un `SnackBar` ou une barre de navigation. Si tu le mettais dans le `body`, tu devrais gérer tout ça toi-même.

---
## Questions de synthèse

1. **`runApp()`** : donne le widget racine à Flutter, qui construit l'arbre et l'affiche. *Sans lui : écran vide.*
2. **Arbre de widgets** : chaque widget est le parent/enfant d'autres. `MaterialApp → Scaffold → Column → Text`. Flutter reconstruit les branches qui changent.
3. **Un seul `body`, plusieurs éléments** : `body` accepte *un* widget ; on lui donne un widget de mise en page (`Column`, `ListView`…) qui, lui, a plusieurs enfants.
4. **`child` vs `children`** : `child` = 1 widget (`Padding`, `Center`, `Container`, `Expanded`). `children` = liste (`Column`, `Row`, `Stack`, `ListView`).
5. **Quand `StatefulWidget` ?** Quand quelque chose change pendant la vie de l'écran et doit se voir : compteur, case cochée, mot de passe visible, formulaire.
6. **Avantage de la séparation de fichiers** : code découpé, relisible, réutilisable, et travail en équipe sans conflit.

---
## Travail complémentaire – pourquoi ça marche
- **Couleur principale** : `static const Color primaryColor = Color(0xFF1B8A3C);` → définie une fois, utilisée partout (AppBar, titre, FAB). *Attention : c'est une couleur « en dur » ; au TP4 on la remplace par un thème.*
- **`BorderRadius.circular(16)`** : arrondit les coins d'un `Container` via `BoxDecoration`.
- **Slogan** : un simple `Text` de plus dans la `Column`, avec `fontStyle: FontStyle.italic`.
- **Icône du FAB** : il suffit de changer `Icons.add` en `Icons.edit` ; elle reste `+` car l'énoncé le demande.
