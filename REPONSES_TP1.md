# TP1 – EMSI Connect : réponses aux questions

## Partie 1 – Préparer le projet
**Q4. Rôle de `main.dart` ?**
C'est le point d'entrée de l'application. Il contient la fonction `main()`, qui appelle `runApp()` avec le widget racine (`MyApp`). C'est le premier fichier exécuté au lancement.

**Q5. Pourquoi séparer `home_page.dart` de `main.dart` ?**
Pour avoir un code organisé et lisible : `main.dart` ne fait que configurer l'application, et chaque écran vit dans son propre fichier. Cela facilite la maintenance, la réutilisation et l'ajout de nouveaux écrans aux prochains TP (profil, tâches, etc.).

## Partie 2 – Structure principale
**Q6. Différence entre `MaterialApp` et `Scaffold` ?**
`MaterialApp` est le widget racine de l'application : il configure le titre, le thème, la navigation et l'écran de départ (`home`). `Scaffold` est la structure d'*un écran* : il fournit l'`AppBar`, le `body`, le `floatingActionButton`, le `drawer`, etc.

**Q7. Pourquoi `StatelessWidget` convient-il ici ?**
La page est statique : elle n'a aucune donnée qui change au cours du temps. Il n'y a donc pas d'état à gérer ; un `StatelessWidget` est plus simple et plus léger.

## Partie 3 – Barre supérieure
**Q4. Différence entre `Icon` et `IconButton` ?**
`Icon` affiche seulement un pictogramme (non interactif). `IconButton` est un bouton cliquable qui contient une icône et possède un `onPressed`, un `tooltip`, un effet visuel au clic, etc.

## Partie 4 – Contenu principal
**Q7. Rôle de `Column` ?**
Il dispose ses enfants (`children`) verticalement, les uns sous les autres.

**Q8. Différence entre `Padding` et `SizedBox` ?**
`Padding` ajoute une marge *autour d'un widget enfant*. `SizedBox` crée un espace vide de taille fixe (largeur/hauteur) *entre* des widgets, ou impose une taille à son enfant.

## Partie 5 – Rubriques
**Q8. Pourquoi utiliser `Row` à l'intérieur d'une `Column` ?**
La `Column` empile les lignes verticalement, et chaque `Row` place deux rubriques côte à côte horizontalement. On obtient ainsi une grille de 2 lignes × 2 colonnes.

## Partie 6 – Bouton flottant
**Q3. À quoi sert `onPressed` ?**
C'est le callback (fonction) exécuté lorsque l'utilisateur appuie sur le bouton. S'il vaut `null`, le bouton est désactivé.

**Q4. Pourquoi déclarer `floatingActionButton` dans `Scaffold` ?**
Parce que `Scaffold` gère le placement des éléments Material : il positionne automatiquement le bouton en bas à droite, au-dessus du contenu, et le fait cohabiter correctement avec la barre de navigation, la SnackBar, etc.

## 6. Questions de synthèse
1. **`runApp()`** : lance l'application en donnant le widget racine à Flutter, qui l'affiche à l'écran.
2. **Arbre de widgets** : tout écran Flutter est composé de widgets imbriqués les uns dans les autres (parent → enfants) ; cette hiérarchie forme l'arbre de widgets (ex. `MaterialApp` → `Scaffold` → `Column` → `Text`).
3. **Plusieurs éléments alors que `body` reçoit un seul widget** : on place un widget de mise en page (`Column`, `Row`, `ListView`…) comme unique `body`, et il contient plusieurs enfants.
4. **`child` vs `children`** : `child` accepte un seul widget (`Padding`, `Container`, `Center`…) ; `children` accepte une liste de widgets (`Column`, `Row`, `Stack`).
5. **`StatefulWidget`** : quand l'écran contient des données qui changent et doivent mettre à jour l'interface (compteur, formulaire, case cochée, liste de tâches modifiable…), via `setState()`.
6. **Avantage de la séparation `main.dart` / `home_page.dart`** : code mieux structuré, fichiers courts, écrans réutilisables, travail en équipe plus simple et évolution facilitée.

## Travail complémentaire réalisé
- Couleur principale modifiée (vert EMSI `0xFF1B8A3C`) et titre coloré.
- Blocs des rubriques avec bordures arrondies (`BorderRadius.circular(16)`).
- Slogan ajouté sous le titre.
- Deuxième action dans l'`AppBar` (icône de recherche).
- Pour changer l'icône du bouton flottant : remplacer `Icons.add` par une autre icône (ex. `Icons.edit`). Elle est laissée à `Icons.add` car l'énoncé demande un bouton « + ».
