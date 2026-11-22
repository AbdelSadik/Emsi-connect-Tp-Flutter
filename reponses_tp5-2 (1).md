# Réponses TP5-2

Questions de compréhension

1. Pourquoi MultimediaPage doit être un StatefulWidget ?
Parce que l'écran change selon des valeurs qui évoluent : l'image choisie (_image), le chemin de l'audio (_audioPath), _recording et _busy. À chaque changement on appelle setState pour redessiner la page.

2. Différence entre ImageSource.camera et ImageSource.gallery ?
camera ouvre l'appareil photo pour prendre une nouvelle photo. gallery ouvre la galerie pour choisir une image qui existe déjà.

3. Pourquoi pickImage retourne un XFile? ?
XFile est le fichier choisi, et on récupère son chemin avec path. Le point d'interrogation veut dire que ça peut être null, c'est le cas quand l'utilisateur annule. Dans le code on affiche alors le message Sélection annulée.

4. À quoi sert mounted après un await ?
Pendant qu'on attend, l'utilisateur a pu fermer la page. Avec mounted on vérifie que la page existe encore avant d'appeler setState ou d'afficher un message, sinon on aurait une erreur.

5. Pourquoi appeler dispose sur AudioRecorder et AudioPlayer ?
Pour libérer le micro et les ressources audio quand on quitte la page. Sinon le micro peut rester utilisé et la mémoire n'est pas libérée.

6. Différence entre permission refusée et définitivement refusée ?
Refusée : l'utilisateur a dit non cette fois, on peut redemander la permission. Définitivement refusée : le système n'affiche plus la fenêtre de demande. Il faut alors proposer à l'utilisateur d'ouvrir les réglages du téléphone avec openAppSettings(), sans les ouvrir automatiquement.

Ce que j'ai compris du code

Les plugins :
- image_picker pour prendre une photo ou choisir une image.
- record pour enregistrer un fichier audio.
- audioplayers pour écouter cet enregistrement.
- permission_handler pour vérifier et demander les autorisations.

async et await : la caméra et le micro sont des opérations qui prennent du temps. Avec await le programme attend le résultat sans bloquer l'interface.

try, catch et finally : catch attrape les erreurs (permission refusée, matériel absent, erreur du plugin) pour que l'application ne plante pas. finally remet _busy à false dans tous les cas.

_busy : sert à désactiver les boutons pendant une opération (onPressed est null) et à afficher la barre de chargement. Comme ça on évite les doubles clics.

kIsWeb : indique si l'application tourne dans un navigateur. On l'utilise pour ne pas appeler des choses de dart:io (fichiers, Platform) sur le web. Sur le web on affiche l'image avec Image.network et sur mobile avec Image.file.

AudioRecorder : start commence l'enregistrement dans un fichier (question_emsi.m4a), stop l'arrête et retourne le chemin du fichier, dispose libère le micro.

AudioPlayer : DeviceFileSource lit un fichier du téléphone. On appelle stop avant play pour ne pas superposer deux lectures.

Configuration

Android : dans AndroidManifest.xml j'ai ajouté la ligne uses-permission avec android.permission.RECORD_AUDIO avant la balise application. Pour la caméra avec image_picker on n'a pas besoin de déclarer CAMERA.

iOS : dans Info.plist on ajoute NSCameraUsageDescription, NSPhotoLibraryUsageDescription et NSMicrophoneUsageDescription, avec un texte qui explique pourquoi on demande la permission.

Erreurs qu'on peut rencontrer

- MissingPluginException : il faut arrêter complètement l'application puis refaire flutter run. Le hot reload ne recharge pas le code natif.
- Permission micro refusée : vérifier le manifest ou le Info.plist et les réglages du téléphone.
- Pas de caméra sur l'émulateur : tester sur un vrai téléphone ou prendre une image dans la galerie.
- Image.file ne marche pas sur Chrome : on utilise Image.network (c'est déjà fait avec kIsWeb).
- Enregistrement indisponible sur Chrome : le TP est prévu pour Android et iOS.
- Audio perdu après redémarrage : le dossier temporaire n'est pas un stockage permanent.

Accès à la page

Dans le Drawer de home_page.dart j'ai ajouté l'entrée Espace multimédia (icône perm_media). Elle fait un Navigator.pop pour fermer le Drawer, puis un Navigator.push vers MultimediaPage.
