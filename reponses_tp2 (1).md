# Réponses TP2

Partie 2 : Expanded et Flexible

Avec deux Expanded sur la première ligne, les deux rubriques ont exactement la même largeur et elles se partagent toute la ligne.

Quand j'ai remplacé le deuxième Expanded par Flexible avec FlexFit.loose, la deuxième rubrique ne prenait plus toute la place, elle gardait seulement la largeur de son contenu. Les deux cartes n'avaient plus la même taille. C'est pour ça qu'on remet deux Expanded à la fin.

Q4. Rôle de Expanded dans une Row ?
Il donne à son enfant tout l'espace libre de la ligne. Quand il y a deux Expanded, l'espace est partagé à parts égales (sauf si on change le flex).

Q5. Différence entre Expanded et Flexible loose ?
Expanded oblige l'enfant à remplir tout l'espace qu'on lui donne. Flexible avec loose laisse l'enfant plus petit si son contenu est petit, il prend seulement la place dont il a besoin.

Partie 4

Q5. Pourquoi mettre Stack dans un SizedBox avec une hauteur ?
Un Stack empile des widgets les uns sur les autres. Avec une hauteur fixe (150) on a une zone bien définie : le bandeau fait 110 et l'avatar est placé en bas au centre, il dépasse un peu sur le bandeau.

Q6. Différence entre Padding et Container ?
Padding sert seulement à faire un espace. Container peut faire plus de choses : padding, margin, couleur, bordure avec BoxDecoration, taille. Si on veut juste un espace on prend Padding, si on veut aussi décorer on prend Container.

Q7. Pourquoi garder SingleChildScrollView sur la page Profil ?
Pour que la page puisse défiler si le contenu est trop grand pour l'écran (petit téléphone, clavier, informations en plus). Sinon on aurait une erreur de débordement.

Q8. Pourquoi on ne peut pas encore ouvrir le profil en cliquant sur Mon profil ?
Parce qu'on n'a pas encore vu la navigation. Les cartes n'ont pas de onTap, on le fait au TP5 avec Navigator.push.

Partie 5

Adaptation aux petits écrans

Q4. spaceBetween, spaceAround et spaceEvenly sur une Row de trois icônes
Avec spaceBetween, l'espace est mis entre les icônes, la première et la dernière touchent les bords. Avec spaceAround, chaque icône a de l'espace autour d'elle, donc il y a une moitié d'espace sur les bords. Avec spaceEvenly, tous les espaces sont pareils, y compris sur les bords.

Q5. Modifications pour améliorer l'affichage sur petit écran
J'ai utilisé Expanded dans les Row pour que les éléments se partagent la largeur au lieu d'avoir une largeur fixe, j'ai gardé le SingleChildScrollView pour pouvoir défiler, et j'ai réduit certains espaces trop grands. Pour les textes longs, on peut mettre maxLines et overflow ellipsis.

Analyse de code

Le code : une Row avec deux Container de 200 de largeur (un bleu, un orange).

1. Quel problème sur un écran étroit ?
Les deux blocs font 400 de large en tout. Sur un écran plus petit que 400, la Row déborde et on voit la bande jaune et noire avec l'erreur RenderFlex overflowed.

2. Correction avec Expanded
```dart
Row(
  children: [
    Expanded(child: Container(height: 80, color: Colors.blue)),
    Expanded(child: Container(height: 80, color: Colors.orange)),
  ],
)
```

3. Espace de 10 pixels entre les deux blocs
```dart
Row(
  children: [
    Expanded(child: Container(height: 80, color: Colors.blue)),
    const SizedBox(width: 10),
    Expanded(child: Container(height: 80, color: Colors.orange)),
  ],
)
```

4. Premier bloc deux fois plus grand que le second
```dart
Row(
  children: [
    Expanded(flex: 2, child: Container(height: 80, color: Colors.blue)),
    const SizedBox(width: 10),
    Expanded(flex: 1, child: Container(height: 80, color: Colors.orange)),
  ],
)
```
Le premier prend les deux tiers de la largeur et le second un tiers.
