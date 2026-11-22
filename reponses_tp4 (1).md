# Réponses TP4

Questions de compréhension

1. Différence entre TextField et TextFormField ?
TextFormField c'est un TextField fait pour être mis dans un Form. Il a en plus la propriété validator pour contrôler ce qu'on écrit.

2. Rôle de Form ?
Il regroupe plusieurs champs pour pouvoir tous les valider en une seule fois.

3. Pourquoi associer une GlobalKey<FormState> à Form ?
Pour pouvoir retrouver l'état du formulaire depuis le bouton et appeler _formKey.currentState!.validate().

4. Que retourne un validator ?
Il retourne null quand le champ est valide, et un texte (le message d'erreur) quand il est invalide.

5. Pourquoi keyboardType emailAddress ne suffit pas pour valider un email ?
Parce qu'il sert seulement à afficher un clavier adapté (avec le @) sur téléphone. Il ne vérifie rien de ce que l'utilisateur écrit, il faut donc un validator.

6. À quoi sert TextEditingController ? Comment lire sa valeur ?
Il permet de lire ou de modifier le contenu d'un champ. On lit la valeur avec _emailController.text.trim().

7. Pourquoi libérer les contrôleurs dans dispose() ?
Pour libérer la mémoire quand la page est fermée. Sinon les contrôleurs restent en mémoire pour rien.

8. Différence entre StatelessWidget et StatefulWidget dans ce TP ?
LoginPage et RegisterPage sont Stateful parce qu'elles gardent des contrôleurs et une valeur qui change (_showPassword). Une page qui n'a rien qui change reste Stateless.

9. Rôle de setState pour le bouton de visibilité du mot de passe ?
Il change la valeur de _showPassword et dit à Flutter de reconstruire le widget. Sans setState la variable change mais l'écran reste pareil.

10. Pourquoi ne pas afficher un mot de passe dans la console ?
Parce que c'est une information sensible. Les logs peuvent être lus ou copiés par quelqu'un d'autre. On affiche seulement l'email et le message saisie valide.

11. Pourquoi une validation locale ne veut pas dire qu'un compte est créé ?
Parce que les vérifications se font seulement dans l'application. Rien n'est envoyé ni enregistré sur un serveur. C'est pour ça que le message dit compte non créé.

12. À quoi servent ThemeData et ColorScheme.fromSeed ?
ThemeData regroupe le style de toute l'application (couleurs, champs, boutons, AppBar). ColorScheme.fromSeed fabrique une palette de couleurs qui vont bien ensemble à partir d'une seule couleur de départ. Dans mon projet c'est le vert EMSI.

13. Différence entre une couleur écrite en dur et Theme.of(context) ?
Une couleur en dur ne change jamais, il faut la modifier partout et elle ne suit pas le thème sombre. Avec Theme.of(context).colorScheme les couleurs sont cohérentes et s'adaptent au thème clair ou sombre.

14. Fonction de ConstrainedBox(maxWidth: 420) ?
Elle limite la largeur du formulaire. Sur ordinateur ou tablette le formulaire ne s'étire pas sur tout l'écran, et sur un petit téléphone il prend simplement la largeur disponible.

15. Différence entre MediaQuery et LayoutBuilder ?
MediaQuery donne des informations sur toute la fenêtre (taille de l'écran, orientation). LayoutBuilder donne l'espace disponible à l'endroit où le widget est placé, donc c'est plus précis pour adapter une partie de la page.

16. Différence entre ListView et GridView ?
ListView affiche les éléments en liste, l'un sous l'autre (par exemple les cours). GridView les affiche en grille avec plusieurs colonnes (par exemple les rubriques de l'accueil).

Autres questions du TP

Partie 6, question 23 : pourquoi ConstrainedBox est utile sur grand écran ?
Sans lui, les champs seraient très larges sur un écran d'ordinateur, ce qui est pas agréable à remplir. Avec maxWidth 420, le formulaire reste centré et lisible, et il s'adapte quand même aux petits écrans.

Partie 7, question 26 : GridView et ListView, un cas d'usage de chacune
ListView pour une suite d'éléments l'un sous l'autre, comme la liste des cours. GridView pour des éléments en colonnes, comme les rubriques de la page d'accueil.

Dans mon projet, pourquoi shrinkWrap et NeverScrollableScrollPhysics sur la grille ?
Parce que la grille est dans un SingleChildScrollView, donc la page défile déjà. Avec ces deux réglages on évite d'avoir deux défilements l'un dans l'autre. La grille a 2 colonnes quand la largeur est inférieure à 600 et 3 colonnes sinon (avec LayoutBuilder).

Tests faits

- Email vide : le message Email obligatoire s'affiche.
- Email sans @ : Email invalide.
- Mot de passe de 4 caractères : Au moins 8 caractères.
- Inscription avec deux mots de passe différents : Les mots de passe ne correspondent pas.
- Tous les champs valides : un SnackBar de validation locale, sans connexion.
- Bouton oeil : le mot de passe s'affiche puis se cache.
- Écran étroit : les champs restent accessibles, pas de débordement.
- Grand écran : le formulaire est centré et sa largeur est limitée.

Bonus

Pour valider les emails j'ai fait une classe Validators (lib/utils/validators.dart) avec les fonctions email, password, confirmation, fullName et optionalPhone.

Pour le thème clair et sombre, j'ai un ValueNotifier appelé themeModeNotifier. Un ValueListenableBuilder autour de MaterialApp l'écoute. Le bouton ThemeToggleButton change juste sa valeur, et toute l'application change de thème sans modifier les pages une par une.
