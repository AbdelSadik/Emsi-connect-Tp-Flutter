# TP3 – Réponses + explications (fichier d'étude, à supprimer avant la remise)

> Le fichier propre à rendre est `reponses_tp3.txt`. Ici : réponse courte, puis explication avec exemples.

## L'idée centrale du TP3 : les contraintes
Flutter fonctionne ainsi : **le parent donne des contraintes (largeur/hauteur min-max), l'enfant choisit sa taille dedans, le parent le positionne.** Presque toutes les erreurs du TP viennent de là (« hauteur infinie », « overflow »).

---
## 1. Column, SingleChildScrollView, ListView

| Version | Défile ? | Débordement ? | Pourquoi |
|---|---|---|---|
| A : `Column` | Non | **Oui** | additionne les hauteurs, ne défile pas |
| B : `SingleChildScrollView` + `Column` | Oui | Non | le scroll donne une hauteur illimitée à la Column |
| C : `ListView` | Oui | Non | défile nativement |

### Q1. Différence
- `Column` = *disposition* (pas de défilement).
- `SingleChildScrollView` = *enveloppe* qui rend défilant **un** enfant plus grand que l'écran. Il construit **tout** le contenu d'un coup.
- `ListView` = liste défilante, optimisée pour beaucoup d'éléments similaires.

### Q2. Qui rend la page défilante en B ?
Le `SingleChildScrollView`. La `Column` ne fait que placer.

### Q3. Pourquoi l'overflow d'une Column ?
La `Column` demande leur taille naturelle à tous ses enfants et les additionne. Si 25 lignes × 50 px = 1250 px > 800 px d'écran, rien ne permet de voir la suite : bandeau jaune/noir « BOTTOM OVERFLOWED BY … PIXELS ».

### Q4. Page « Mon profil » → `SingleChildScrollView` + `Column`
Contenu **hétérogène** (photo, textes, boutons) et peu nombreux : on veut le contrôle total de la disposition. `ListView` sert à des éléments **du même type**.

### Q5. 100 cours → `ListView.builder`
Il ne construit que les éléments visibles (+ une marge). 100 cartes ne sont pas toutes en mémoire : plus rapide et plus fluide. (`SingleChildScrollView` créerait les 100.)

### Q6. Une ListView peut-elle mélanger des widgets différents ?
Oui : `children` accepte tout widget (texte, carte, image, séparateur…).

---
## 2. Liste simple de modules

### `padding` vs `SizedBox`
- `padding` : espace **autour** du contenu (ex. bords de la `ListView`).
- `SizedBox(height: 12)` : espace **entre** deux widgets.

### `child` vs `children`
Un seul widget vs une liste (voir TP1).

---
## 3. Card

### Test `elevation: 0` puis `6`
- `0` : carte plate, presque indistincte du fond.
- `6` : ombre marquée, la carte « flotte ».

### `margin` vs `padding`
- `margin` : espace **extérieur** (entre la carte et ses voisines).
- `padding` : espace **intérieur** (entre le bord et le contenu).
Moyen mnémotechnique : *le **m**argin est à l'**ex**térieur (comme une marge de page) ; le padding est un rembourrage à l'intérieur.*

### À quoi sert `elevation` ?
Elle règle la « hauteur » virtuelle de la surface Material, donc la taille de l'ombre. Plus c'est haut, plus l'ombre est grande et floue.

### `Card` vs `Container`
- `Card` : widget Material **prêt à l'emploi** (ombre, coins arrondis, couleur du thème).
- `Container` : boîte **générique** (taille, marges, couleur, bordure) sans style Material.
Besoin d'une jolie carte rapidement → `Card`. Besoin de décorer sur mesure → `Container` + `BoxDecoration`.

---
## 4. ListTile

| Propriété | Rôle | Exemple de ton code |
|---|---|---|
| `leading` | début de ligne | icône + numéro |
| `title` | info principale | nom du module |
| `subtitle` | info secondaire | enseignant, heures |
| `trailing` | fin de ligne | `Icons.chevron_right` |

```
[leading] [title            ] [trailing]
          [subtitle         ]
```

### Pourquoi `ListTile` plutôt que Row + Column ?
Il gère déjà alignements, espacements Material, hauteur, effet d'onde et `onTap`. Refaire tout à la main = plus de code et plus de risques d'incohérence.

### `Card` doit-elle contenir un `ListTile` ?
Non, `Card` accepte n'importe quel enfant. `ListTile` est juste pratique pour des lignes d'information.

### Titres longs sur petit écran
`maxLines: 2` + `overflow: TextOverflow.ellipsis` coupent proprement (« … ») au lieu de déborder ; `isThreeLine: true` réserve la place du sous-titre sur 2 lignes.

---
## 5. onTap

### Qu'est-ce qu'un callback ?
Une **fonction qu'on donne à un widget** pour qu'il l'appelle plus tard. Analogie : tu laisses ton numéro de téléphone (la fonction) ; on t'appelle quand l'événement a lieu.

### Pourquoi `onTap` ne s'exécute pas à l'affichage ?
```dart
onTap: () { ... }     // on passe la fonction : mémorisée
onTap: maFonction()   // ❌ on l'appelle tout de suite !
```
Sans parenthèses d'appel, la fonction attend l'événement « toucher ».

### `onTap` vs `onPressed`
Même principe (callback d'appui). `onPressed` : propriété des **boutons** (`ElevatedButton`, `IconButton`, FAB). `onTap` : `ListTile`, `InkWell`, `GestureDetector`.

---
## 6. ListView.builder

```dart
ListView.builder(
  itemCount: modules.length,
  itemBuilder: (context, index) { final module = modules[index]; ... },
)
```
- **`itemCount`** : nombre total d'éléments possibles. Sans lui, le builder ne sait pas s'arrêter (liste infinie → erreurs d'index).
- **`index`** : position (0, 1, 2…) de l'élément en construction.
- **Pourquoi `modules[index]` marche** : `index` va de `0` à `length − 1`, exactement les positions valides.
- **`ListView(children)` vs `.builder`** : le 1ᵉʳ crée tout tout de suite ; le builder crée **à la demande** les éléments visibles, avec **un seul** modèle de carte écrit.
- **Ajouter 2 modules** : on ajoute 2 entrées dans la liste ; **aucune** carte à réécrire. C'est tout l'intérêt de séparer *données* et *affichage*.

---
## 7. Contraintes de hauteur (le piège classique)

```dart
Column(children: [ Text('Titre'), ListView(...) ])   // ❌ "Vertical viewport was given unbounded height"
Column(children: [ Text('Titre'), Expanded(child: ListView(...)) ])   // ✅
```
- La `Column` donne une hauteur **illimitée** à ses enfants. Une `ListView` veut remplir la hauteur disponible : « tout l'infini » n'a pas de sens → erreur.
- `Expanded` donne à la `ListView` **tout l'espace restant** (écran − titre) : hauteur finie → elle sait où défiler. Le titre reste fixe, seule la liste bouge.
- **Pas de `SingleChildScrollView` autour d'une `ListView`** : double défilement, conflits de contraintes, et perte de l'optimisation du builder.

---
## 8. Défis (comment ils sont faits)
- **A – Map** : `{'nom': ..., 'enseignant': ..., 'heures': ..., 'icone': ...}` ; lecture `module['nom'] as String` (cast car la Map est `dynamic`).
- **B – numéro** : `CircleAvatar(child: Text('${index + 1}'))` (+1 car l'index commence à 0).
- **C – SnackBar** : `ScaffoldMessenger.of(context).showSnackBar(...)`. `hideCurrentSnackBar()` avant évite l'empilement.
- **D – titres longs** : `maxLines`, `ellipsis`, `isThreeLine`, marge de 12 entre cartes.

---
## À retenir en 5 lignes
1. `Column` ne défile pas ; `ListView` oui.
2. `ListView` dans `Column` → `Expanded`.
3. Longue liste → `ListView.builder`.
4. `margin` dehors, `padding` dedans.
5. Callback = fonction passée, **non appelée**.
