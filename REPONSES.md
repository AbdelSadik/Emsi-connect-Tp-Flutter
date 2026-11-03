# TP2 – Réponses aux questions

## Partie 2 – Expanded et Flexible

**Observation (deux Expanded → un Expanded + un Flexible loose).**
Avec deux `Expanded`, chaque rubrique reçoit exactement la moitié de la largeur disponible (moins l'espace de 12 px). Avec `Flexible(fit: FlexFit.loose)`, la deuxième rubrique peut être *plus étroite* que l'espace proposé : elle prend seulement la largeur dont son contenu a besoin. Les deux cartes n'ont alors plus la même largeur.

**4. Rôle de Expanded dans une Row ?**
`Expanded` force son enfant à occuper tout l'espace restant sur l'axe principal (ici la largeur). Quand il y a plusieurs `Expanded`, l'espace est partagé selon leur `flex`. Il évite aussi le débordement (overflow) : l'enfant reçoit une largeur bornée et son contenu s'adapte (texte qui passe à la ligne, etc.).

**5. Différence Expanded / Flexible (fit: FlexFit.loose) ?**
`Expanded` = `Flexible(fit: FlexFit.tight)` : l'enfant *doit* remplir l'espace alloué. `Flexible` avec `FlexFit.loose` : l'enfant *peut* l'occuper mais n'y est pas obligé, il peut rester plus petit.

## Partie 4 – Bilan

**5. Pourquoi placer Stack dans un SizedBox de hauteur définie ?**
Dans une `Column` placée dans un `SingleChildScrollView`, la hauteur n'est pas bornée. Un `Stack` dont les enfants sont `Align`/`Positioned` n'a pas de taille « naturelle » : il lui faut une hauteur imposée. Le `SizedBox(height: 150)` fixe la zone, et l'avatar (qui dépasse du fond de 110 px) peut se placer en bas du bandeau.

**6. Différence Padding / Container ?**
`Padding` fait une seule chose : ajouter une marge intérieure autour de son enfant. `Container` est un widget « tout-en-un » (padding, margin, couleur, `BoxDecoration`, taille, alignement…). On utilise `Padding` quand on n'a besoin que d'un espacement, c'est plus léger et plus lisible.

**7. Pourquoi garder SingleChildScrollView sur la page Profil ?**
Le contenu (bandeau, 5 infos, boutons, carte étudiant) peut dépasser la hauteur de l'écran, surtout sur un petit téléphone ou en mode paysage. Sans scroll, Flutter affiche une erreur « RenderFlex overflowed ».

**8. Pourquoi ne peut-on pas encore ouvrir le profil en cliquant sur « Mon profil » ?**
Les rubriques sont de simples `Container` sans geste associé (pas de `InkWell`/`GestureDetector`/`onTap`) et aucune navigation (`Navigator.push`) n'est encore programmée : c'est prévu pour un prochain TP.

## Partie 5 – Adaptation aux petits écrans

- Chaque information utilise `Row` + `Expanded` autour du texte : à 320 px, une valeur longue passe à la ligne au lieu de déborder.
- Les deux boutons ont un `padding` horizontal réduit (8 px) et sont dans des `Expanded` : « Modifier le profil » peut passer sur deux lignes sans overflow.
- Dans la carte étudiant : nom en `maxLines: 2` + `ellipsis`, nom de l'école dans un `Expanded`, avatar de taille modérée.
- Toute la page reste dans un `SingleChildScrollView`.

**Test des alignements sur une Row de 3 icônes :**
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // puis spaceAround, puis spaceEvenly
  children: [Icon(Icons.home), Icon(Icons.search), Icon(Icons.person)],
)
```
- `spaceBetween` : 1ʳᵉ et dernière icônes collées aux bords, espace libre réparti *entre* les icônes uniquement.
- `spaceAround` : espace identique autour de chaque icône → aux bords, la moitié de l'espace entre deux icônes.
- `spaceEvenly` : tous les espaces (bords et entre icônes) sont strictement égaux.

## Analyse de code

**1. Problème sur un écran étroit ?**
Deux blocs de 200 px = 400 px. Sur un écran de 360 px (ou 320 px), la `Row` déborde : bande rouge/jaune « RIGHT OVERFLOWED BY … PIXELS ». Une `Row` ne passe pas à la ligne et ne réduit pas ses enfants à largeur fixe.

**2, 3, 4. Code corrigé** (espace de 10 px, premier bloc 2× plus large) :
```dart
Row(
  children: [
    Expanded(
      flex: 2, // le premier bloc prend 2 parts sur 3
      child: Container(height: 80, color: Colors.blue),
    ),
    const SizedBox(width: 10), // espace horizontal sans toucher à la hauteur
    Expanded(
      flex: 1,
      child: Container(height: 80, color: Colors.orange),
    ),
  ],
)
```
(Les `width: 200` sont supprimées : c'est `Expanded` qui impose la largeur.)

## Défi bonus – carte étudiant
Voir `_StudentCard` dans `lib/screens/profile_page.dart` : `Container` + `BoxDecoration` (dégradé, coins arrondis, ombre), `Stack` + `Positioned` (icône décorative en fond), `Row`, `Column`, `Padding`, `SizedBox`, photo, nom, filière/niveau, n° étudiant fictif, icône de l'établissement.
