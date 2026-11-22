# Réponses TP1

Partie 1

Q4. Quel est le rôle de main.dart ?
C'est le fichier par lequel l'application démarre. Dans main() on appelle runApp(MyApp()), et MyApp retourne la MaterialApp qui configure l'application.

Q5. Pourquoi séparer home_page.dart de main.dart ?
Pour que le code reste clair. main.dart garde seulement la configuration et chaque écran a son fichier. Comme ça on peut modifier une page sans toucher au reste, et c'est plus facile quand on ajoute d'autres pages dans les prochains TP.

Partie 2

Q6. Différence entre MaterialApp et Scaffold ?
MaterialApp est la base de toute l'application (titre, thème, page de départ). Il y en a une seule. Scaffold c'est la structure d'une page : on y met l'appBar, le body, le bouton flottant, etc. Chaque page a son Scaffold.

Q7. Pourquoi StatelessWidget convient ici ?
Parce que la page d'accueil ne change pas pendant qu'on l'utilise. Elle n'a pas de données à modifier, donc pas besoin de setState.

Partie 3

Q4. Différence entre Icon et IconButton ?
Icon affiche juste une icône. IconButton est un bouton sur lequel on peut cliquer, il a un onPressed.

Partie 4

Q7. Rôle de Column ?
Elle met ses enfants les uns sous les autres, verticalement. Elle ne défile pas toute seule, donc on la met dans un SingleChildScrollView si le contenu peut dépasser l'écran.

Q8. Différence entre Padding et SizedBox ?
Padding ajoute de l'espace autour d'un widget. SizedBox donne une taille fixe, et on s'en sert souvent pour mettre un espace entre deux widgets, par exemple SizedBox(height: 12).

Partie 5

Q8. Pourquoi utiliser Row dans une Column ?
La Column met les lignes les unes sous les autres, et chaque Row met deux rubriques côte à côte. Avec ça on obtient 2 lignes de 2 rubriques.

Partie 6

Q3. À quoi sert onPressed ?
C'est la fonction qui s'exécute quand on appuie sur le bouton. Par exemple on y met debugPrint('Fonctionnalité bientôt disponible').

Q4. Pourquoi déclarer floatingActionButton dans Scaffold ?
Parce que c'est le Scaffold qui le place (en bas à droite, au dessus du contenu) et qui gère sa position avec les autres éléments, comme les SnackBar.

Questions de synthèse

1. Rôle de runApp() ?
Elle lance l'application : elle prend le widget de départ et l'affiche à l'écran.

2. Qu'est-ce qu'un arbre de widgets ?
Tout est un widget et chaque widget est dans un autre : MaterialApp contient Scaffold, qui contient Column, qui contient Text, etc. Cette organisation en parents et enfants s'appelle l'arbre de widgets.

3. Comment afficher plusieurs éléments alors que body en reçoit un seul ?
On met dans body un seul widget qui peut avoir plusieurs enfants, comme Column, Row ou ListView.

4. Différence entre child et children ?
child prend un seul widget. children prend une liste de widgets.

5. Quand utiliser StatefulWidget ?
Quand il y a des données qui changent dans la page, par exemple un mot de passe qu'on affiche ou qu'on cache, un interrupteur, une image choisie. On utilise alors setState pour redessiner la page.

6. Avantage de séparer main.dart et home_page.dart ?
Le code est mieux rangé, plus lisible, et on peut réutiliser les pages facilement.
