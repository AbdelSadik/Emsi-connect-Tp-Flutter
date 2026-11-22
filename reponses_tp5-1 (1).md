# Réponses TP5-1

Partie I : la navigation

Navigator garde une pile de pages. 
- push ajoute une page en haut de la pile.
- pop ferme la page actuelle et revient à la précédente.
- pushReplacement remplace la page actuelle par une autre.
- pushAndRemoveUntil ajoute une page et supprime les anciennes selon une condition.

C'est le principe LIFO (Last In, First Out) : la dernière page ouverte est la première fermée.

Dans Navigator.push :
- context permet de savoir depuis quel widget on navigue.
- MaterialPageRoute crée la route, c'est à dire la nouvelle page avec son animation.
- builder construit le widget de destination.
- const CoursesPage() est la page à afficher. On peut mettre const parce que son constructeur est const.

Partie II : Drawer

Différence entre DrawerHeader et UserAccountsDrawerHeader ?
DrawerHeader est un en-tête simple où on met ce qu'on veut dans child. UserAccountsDrawerHeader est fait pour afficher un compte : il a déjà accountName, accountEmail et currentAccountPicture.

Pourquoi un premier Navigator.pop(context) dans chaque onTap du Drawer ?
Il sert à fermer le Drawer. Ensuite le push ouvre la page. Si on ne le fait pas, le Drawer reste ouvert dans la pile et on le retrouve en revenant en arrière.

Pourquoi pushAndRemoveUntil avec (route) => false pour Déconnexion ?
La condition retourne toujours false, donc toutes les pages de la pile sont supprimées et on ne peut plus revenir en arrière avec le bouton retour. C'est juste une simulation, il n'y a pas encore de vraie session.

J'ai aussi ajouté un Divider et l'entrée À propos dans le menu, qui ouvre AboutPage.

Partie III : StatefulWidget

Pourquoi SettingsPage est un StatefulWidget ?
Parce que les interrupteurs ont une valeur qui change (_notificationsEnabled, _compactMode, _showExtraInfo). Un StatelessWidget ne peut pas garder une valeur modifiable.

Comment marche SwitchListTile ?
value donne l'état actuel de l'interrupteur, onChanged reçoit la nouvelle valeur, et setState reconstruit l'écran avec cette valeur.

Pourquoi les interrupteurs reviennent à leur valeur de départ quand on rouvre la page ?
Les variables sont dans l'objet State. Quand on ferme la page il est détruit, et en rouvrant on en crée un nouveau avec les valeurs initiales. Elles ne sont pas enregistrées.

Que fait le mode compact ?
Il change le padding de la carte État des paramètres : 8 s'il est activé et 20 sinon.

Pour le troisième interrupteur, j'ai une variable booléenne _showExtraInfo et un if (_showExtraInfo) qui affiche le texte explicatif quand il est activé.

Partie IV : transmission de données

Pourquoi transmettre des paramètres ?
Pour que la page de détails reçoive ses valeurs par son constructeur (studentName et program), au lieu d'écrire les données en dur dans la page.

À quoi sert required ?
Il oblige celui qui appelle la page à donner ce paramètre. Si on l'oublie, le code ne compile pas.

Pourquoi StudentDetailsPage est un StatelessWidget ?
Parce qu'elle ne modifie pas les données, elle affiche seulement ce qu'elle reçoit.

Partie V : intégration

Pourquoi pushReplacement après la validation du login ?
Pour remplacer la page de connexion par l'accueil. Comme ça le bouton retour ne ramène pas au formulaire.

Est-ce une vraie authentification ?
Non. On vérifie seulement les champs en local. La vraie vérification sera faite dans un autre TP.

Parcours de test que j'ai fait

1. Login, test des messages de validation.
2. Valeurs valides, on arrive sur HomePage.
3. Ouverture du Drawer, on voit le nom et l'email.
4. Mes cours, puis retour.
5. Profil, puis Voir les détails, les données sont bien transmises.
6. Paramètres, activer et désactiver les interrupteurs.
7. Retour à l'accueil puis réouverture des paramètres : les valeurs sont revenues au début.
8. Déconnexion, on retourne sur le login.
9. La grille de l'accueil est toujours adaptative.
10. Test sur une fenêtre étroite et sur Chrome.
