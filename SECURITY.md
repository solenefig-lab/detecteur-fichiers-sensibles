# Politique de sécurité

La sécurité est au cœur de ce projet de diagnostic local d’hygiène numérique.  
Tout signalement de vulnérabilité ou comportement inattendu est pris au sérieux afin d’améliorer la fiabilité de l’outil.

## Périmètre

Ce projet est un script Bash de diagnostic de première intention, destiné à l’audit local d’un poste de travail.  
Il ne doit pas être utilisé pour collecter, exfiltrer ou diffuser des données hors du périmètre autorisé.

## Données analysées

Le script réalise un traitement local des fichiers présents dans le périmètre fourni en argument.
Aucune donnée analysée n'est transmise automatiquement à un service externe.
Les utilisateurs doivent toutefois veiller à protéger les rapports générés, qui peuvent contenir des chemins ou informations sensibles.

## Signalement d’une vulnérabilité

Merci de signaler toute vulnérabilité via les **signalements privés GitHub** de ce dépôt.  
Merci de ne pas ouvrir d’issue publique pour un problème de sécurité sensible.

## Informations à fournir

Merci d’ajouter, si possible :

- une explication claire du problème ;
- le contexte dans lequel il est apparu ;
- l’impact observé ;
- les étapes de reproduction ;
- une capture d’écran ou un rapport d’audit si pertinent.

## Délai de réponse

Nous nous efforçons de répondre sous **1 semaine ouvrée**.

## Règles de divulgation

Merci de ne pas publier publiquement les détails d’une vulnérabilité avant coordination avec la maintenance du projet.

## Limites

Ce projet est fourni sans garantie. Les utilisateurs sont responsables de son déploiement et de son utilisation conformément à leurs politiques internes et aux réglementations applicables (ex : RGPD, NIS2 pour les entités concernées).

Ce script est destiné à un usage local. Les risques liés à une utilisation non conforme du script (par exemple une exécution avec des privilèges élevés sans nécessité opérationnelle) ne relèvent pas du périmètre de sécurité de ce projet.

Les rapports générés peuvent contenir des informations sensibles (chemins de fichiers, noms de ressources). Ils doivent être protégés selon les règles de sécurité applicables à l'organisation utilisatrice.


## Licence

Le code de ce dépôt (audit_hygiene.sh et scripts associés) est distribué sous licence MIT.

Les fichiers de configuration et dictionnaires (patterns.txt, fichiers_sensibles.txt) sont fournis à titre d'exemples et peuvent être librement adaptés à votre contexte organisationnel.

Voir le fichier [LICENSE](./LICENSE-MIT) pour les termes complets.

© 2026 Solène Figueiredo