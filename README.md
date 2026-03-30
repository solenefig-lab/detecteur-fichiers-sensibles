# Détecteur Automatique de Fichiers Sensibles

## Contexte & Sécurité
Script Bash conçu pour l'audit rapide de systèmes de fichiers afin d'identifier des données critiques exposées (mots de passe, tokens, secrets). 

**Objectif :** Réduire la surface d'attaque en appliquant les principes du **Privacy by Design** (RGPD Art. 25).

### Fonctionnalités
- Scan récursif de répertoires spécifiques.
- Filtrage par types de fichiers sensibles (`.txt`, `.csv`, `.md`).
- Détection par mots-clés (regex insensibles à la casse).

### 💻 Utilisation
```bash
chmod +x detecteur_sensible.sh
./detecteur_sensible.sh /chemin/vers/dossier
