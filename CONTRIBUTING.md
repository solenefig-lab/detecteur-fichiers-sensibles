
# Contribuer au projet Détecteur de fichiers sensibles

Merci de ton intérêt pour ce projet ! Toute contribution est la bienvenue, que ce soit pour :  
- **Améliorer les dictionnaires** (`patterns.txt`, `fichiers_sensibles.txt`).  
- **Optimiser le script** (performance, nouvelles fonctionnalités).  
- **Corriger des bugs** ou **améliorer la documentation**.  

---

## Règles générales

- **Les contributions** sont intégrées au dépôt sous les conditions de licence définies dans le fichier licence MIT](./LICENSE-MIT).
- **Pas de données réelles** : Ne partagez pas de secrets, PII ou données sensibles dans les Issues/PRs.

---

## Signaler un bug

1. Vérifiez que le bug n’a pas déjà été signalé (recherchez dans les [Issues](https://github.com/solenefig-lab/detecteur-fichiers-sensibles/issues).
2. Ouvrez une **nouvelle Issue** avec :  
   - Un **titre descriptif** (ex : "Faux positif sur les fichiers `.log`").  
   - Une **description claire** :  
     - Étapes pour reproduire.  
     - Comportement attendu vs. observé.   
     - Capture d’écran ou logs si pertinent.  
   - Votre **environnement** (OS, version de Bash, etc.).  

Voir aussi : [Politique de sécurité](./SECURITY.md)   

---

## Proposer une amélioration 

Avant d'ajouter une fonctionnalité, vérifiez qu'elle reste cohérente avec l'objectif du projet : fournir un outil léger de diagnostic d'hygiène numérique.

1. **Fork** le dépôt et créez une branche dédiée (`git checkout -b feature/ma-fonctionnalité`).
2. **Testez** vos modifications localement.
3. **Soumettez une Pull Request** avec :

   - Un **titre clair** (ex : "Ajout de patterns pour les clés AWS").
   - Une **description** expliquant :
     - Le **pourquoi** de la modification.
     - Les **tests** effectués.
     - Les **impacts** potentiels (ex : faux positifs réduits).

4. **Respectez les conventions** :

   - Code : Suivez le style existant (indentation, noms de variables).
   - Documentation : Mettez à jour le README si nécessaire.

---

### Modifications des dictionnaires

Lors de l'ajout d'un nouveau pattern :

- expliquer le risque couvert ;
- préciser le risque de faux positifs ;
- fournir un exemple de fichier de test si nécessaire.

---

## Contribuer à la documentation

- Les améliorations de la **documentation** (README, guides) sont les bienvenues !
- Pour les **traductions** (ex : anglais → français), ouvrez une Issue pour coordonner.

---

## Besoin d’aide ?

- Pour les questions générales, utilisez les **Issues GitHub**.
- Pour des problèmes techniques, ouvrez une **Issue**.
- Pour des questions sensibles, utilisez les **signalements privés GitHub** de ce dépôt.

---

## Remerciements
Merci à tous les contributeurs pour leur aide !

© 2026 Solène Figueiredo