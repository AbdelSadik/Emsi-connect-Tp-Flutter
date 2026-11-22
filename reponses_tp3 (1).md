# Réponses TP3

Column, SingleChildScrollView et ListView

J'ai testé les trois versions avec 25 éléments :
- A (Column seule) : les éléments sont bien l'un sous l'autre mais on ne peut pas défiler, et il y a une erreur de débordement.
- B (SingleChildScrollView avec Column) : les éléments sont verticaux, on peut défiler, pas de débordement.
- C (ListView) : pareil que B, ça défile et il n'y a pas de débordement.

Q1. Différence entre Column, SingleChildScrollView et ListView ?
Column place les éléments verticalement mais ne défile pas. SingleChildScrollView rend son enfant défilant quand il dépasse l'écran. ListView est une liste qui défile directement.

Q2. Dans la solution B, quel widget rend la page défilante ?
C'est le SingleChildScrollView, pas la Column.

Q3. Pourquoi une Column seule peut provoquer un débordement ?
Parce qu'elle ne défile pas. Si les éléments sont plus hauts que l'écran, Flutter affiche l'erreur RenderFlex overflow.

Q4. Quel choix pour une page Mon profil ?
SingleChildScrollView avec Column, parce qu'il y a peu de parties et elles sont toutes différentes (photo, infos, boutons).

Q5. Quel choix pour une liste de 100 cours ?
ListView.builder, car il construit seulement les éléments qu'on voit à l'écran, donc c'est plus rapide que de créer 100 widgets d'un coup.

Q6. Une ListView peut-elle afficher des widgets différents ?
Oui, dans children on peut mettre n'importe quels widgets.

Liste simple de modules

Différence entre padding et SizedBox ?
padding met un espace autour du contenu (par exemple autour de toute la liste). SizedBox met un espace entre deux éléments.

Différence entre child et children ?
child c'est un seul widget, children c'est une liste de widgets.

Les Card

J'ai testé elevation 0 et elevation 6. Avec 0 la carte est plate, il n'y a pas d'ombre. Avec 6 l'ombre est forte et la carte a l'air de flotter au dessus du fond.

Différence entre margin et padding ?
margin c'est l'espace à l'extérieur de la carte. padding c'est l'espace à l'intérieur, entre le bord de la carte et son contenu.

À quoi sert elevation ?
À donner une ombre à la carte, pour faire un effet de profondeur.

Différence entre Card et Container ?
Card est une surface Material déjà prête, avec ombre et coins arrondis. Container est plus général, on s'en sert pour placer, dimensionner ou décorer un widget.

Les ListTile

Rôle de leading, title, subtitle et trailing ?
leading est l'élément au début (une icône ou un numéro). title est l'information principale (le nom du module). subtitle est l'information en dessous (l'enseignant, les heures). trailing est l'élément à la fin (la flèche).

Pourquoi ListTile plutôt que Row et Column ?
Parce qu'il est déjà tout prêt : les espaces et l'alignement sont gérés, on peut cliquer dessus et il y a l'effet au toucher. Ça évite d'écrire beaucoup de code.

Card doit-elle obligatoirement contenir un ListTile ?
Non, une Card peut contenir n'importe quel widget.

onTap

Qu'est-ce qu'un callback ?
C'est une fonction qu'on donne à un widget, et qui sera appelée plus tard quand quelque chose arrive (par exemple un clic).

Pourquoi le code dans onTap ne s'exécute pas dès l'affichage de la page ?
Parce qu'on donne la fonction sans l'appeler (on écrit () { ... } et pas de parenthèses d'appel). Elle s'exécute seulement quand on touche l'élément.

Différence entre onTap et onPressed ?
C'est le même principe. onTap est utilisé sur ListTile, InkWell, GestureDetector. onPressed est utilisé sur les boutons.

Le SnackBar dans mon code (courses_page.dart) :
```dart
onTap: () {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Module sélectionné : $nom')),
  );
},
```

ListView.builder

Rôle de itemCount ?
Il dit combien d'éléments la liste doit construire, ici modules.length.

Que représente index ?
La position de l'élément en cours de construction. Ça commence à 0.

Pourquoi modules[index] fonctionne ?
Parce que index va de 0 jusqu'à modules.length moins 1, donc à chaque carte on prend le module qui correspond dans la liste.

Différence entre ListView(children) et ListView.builder ?
Avec children, tous les widgets sont créés au début. Avec builder, ils sont créés au fur et à mesure qu'on défile, donc c'est mieux pour les longues listes. En plus, pour ajouter un module il suffit de l'ajouter dans la liste Dart, sans écrire une nouvelle Card.

Contraintes de hauteur

Pourquoi Expanded corrige le problème dans une Column ?
La Column donne une hauteur sans limite à ses enfants, et la ListView a besoin d'une hauteur définie pour pouvoir défiler. Expanded lui donne l'espace qui reste, qui est limité. Dans mon test le titre Modules du semestre reste fixe pendant que la liste défile.

Pourquoi ne pas entourer ListView de SingleChildScrollView à chaque fois ?
Parce que ListView défile déjà. Si on met les deux, on a deux zones de défilement l'une dans l'autre, ça peut donner des erreurs de hauteur et on perd l'avantage du builder.

Défis

A. J'ai fait une liste de Map avec nom, enseignant, heures et icone, et je lis les valeurs avec modules[index]['nom'].
B. Le numéro du module est dans un CircleAvatar avec Text('${index + 1}').
C. Le SnackBar affiche le nom exact du module choisi.
D. Pour les écrans étroits j'ai mis maxLines: 2 et overflow ellipsis sur les titres, parce qu'il y a un module avec un titre très long (Architecture logicielle et conception orientée objet avancée).
