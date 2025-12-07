# TP1 : Interfaces Graphiques Flutter (Profile & Quizz)

Ce projet est une application mobile réalisée dans le cadre du TP1 de développement mobile. Il a pour but de démontrer la maîtrise des concepts fondamentaux de Flutter et Dart, notamment la différence entre les widgets Stateless et Stateful.

## Aperçu de l'application

L'application se compose d'un menu principal permettant de naviguer vers deux exercices distincts :

### Exercice 1 : Profile Card
* Affichage d'une carte de visite statique.
* Utilisation du widget Stack pour la superposition (Avatar sur Carte).
* Intégration d'un lien externe vers Instagram (utilisation du package url_launcher).
* Chargement d'images depuis les assets locaux pour garantir l'affichage hors connexion.

### Exercice 2 : Quizz Interactif
* Jeu de questions/réponses dynamique.
* Gestion de l'état (via setState) pour la navigation entre les questions.
* Calcul du score en temps réel affiché dans la barre d'application.
* Feedback visuel immédiat (SnackBar vert ou rouge) après chaque réponse.
* Écran de fin de jeu avec animation conditionnelle (Victoire ou Défaite) et options pour rejouer ou revenir au menu.


## Installation et Exécution

Pour exécuter ce projet sur votre machine locale, suivez les étapes ci-dessous :

1.  Pré-requis :
    Assurez-vous d'avoir le SDK Flutter installé et configuré.

2.  Récupération du projet :
    Clonez le dépôt ou extrayez l'archive ZIP du projet.

3.  Installation des dépendances :
    Exécutez la commande suivante à la racine du projet pour installer les paquets requis (notamment url_launcher) :

    ``` flutter pub get ```

4.  Lancement de l'application :
    Lancez un émulateur ou connectez un appareil physique, puis exécutez :

    ```flutter run``` 

## Fonctionnalités techniques clés

* Navigation : Implémentation de Navigator.push pour la gestion de la pile d'écrans.
* Gestion des Assets : Configuration explicite du fichier pubspec.yaml pour l'inclusion des images.
* Animations : Utilisation de TweenAnimationBuilder pour l'écran de résultat du quiz.
* Deep Linking : Ouverture d'applications tierces via des URL.

## Auteur

GRARI Youssef