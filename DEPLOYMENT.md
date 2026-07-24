# Guide de déploiement outil détecteur de fichiers sensibles.

Ce guide explique comment **installer, configurer et utiliser** le script d'audit d'hygiène numérique dans une PME.

_Note : Ce script Bash constitue un **outil de diagnostic de première intention**, conçu pour objectiver l'exposition de données sensibles sur un poste de travail : secrets, clés cryptographiques, fichiers de configuration, dumps de bases de données, données à caractère personnel._

---

## Installation

1. **Télécharger le dépôt** :
   ```bash
   git clone https://github.com/solenefig-lab/detecteur-fichiers-sensibles.git
   cd detecteur-fichiers-sensibles

2. Rendre le script exécutable :
```bash
chmod +x audit_hygiene.sh
```

3. Vérifier les dépendances :

Bash ≥ 3.2 (vérifiez avec bash --version).
grep avec support des regex étendues (vérifiez avec grep -E --version).

---

## Configuration


### Adapter les dictionnaires :

Modifiez [fichiers_sensibles.txt](fichiers_sensibles.txt) pour ajouter les noms de fichiers critiques spécifiques à votre PME.
Modifiez [patterns.txt](./patterns.txt) pour ajouter des mots-clés métiers (ex : noms de projets internes).

---

### Options

1. Exclure des chemins
Le script analyse récursivement le répertoire fourni. Pour limiter le périmètre, lancez le scan directement sur le dossier souhaité.

```bash
./audit_hygiene.sh ~/projets/mon-projet
```

2. Mode silencieux
Pour exécuter le script sans sortie console (utile pour les tâches cron) :

```bash
./audit_hygiene.sh /chemin/à/analyser > /dev/null 2>&1
```

3. Intégration avec des outils existants

Ce script peut être intégré à vos outils pour **automatiser les audits** et **centraliser les alertes**.

| Outil | Cas d’usage | Méthode | Exemple |
| --- | --- | --- | --- |
| CI/CD | Bloquer les merges si des secrets sont détectés. | Exécuter le script dans un pipeline (GitHub Actions, GitLab CI, Jenkins). | Voir [docs GitHub Actions](https://docs.github.com/en/actions) |
| SIEM | Centraliser les alertes (Wazuh, Splunk). | Le rapport CSV peut constituer une sortie intermédiaire pour une intégration ultérieure avec des outils de supervision ou de gestion des incidents. | crontab -e + wazuh-agent |
| Monitoring | Suivre l’évolution des alertes. | Exporter les métriques (ex : nombre d’alertes) vers Prometheus/Grafana. | Script Bash + Prometheus |
| Gestion d’incidents | Créer des tickets automatiques. | Utiliser l’API de TheHive ou Jira pour créer un ticket à partir du rapport CSV. | curl -X POST [API_URL] -d "@audit_report.csv" |


---

## Utilisation
### Premier scan

```bash
./audit_hygiene.sh /home/user/
```

### Scan silencieux (pour cron)

```bash
./audit_hygiene.sh /home/user/ --csv --output rapport.csv
```

### Planifier un scan régulier (avec cron)

Ouvrez le crontab :
```bash
crontab -e
```

Ajoutez une ligne pour un scan hebdomadaire (ex : tous les lundis à 2h) :
```bash
0 2 * * 1 /chemin/vers/audit_hygiene.sh /home/user/ --csv --output /chemin/vers/rapports/rapport_$(date +\%Y-\%m-\%d).csv
```

---

## Interprétation des résultats

Fichiers analysés : Nombre total de fichiers scannés.
Alertes par catégorie :

Nomenclature : Fichiers avec des noms critiques (ex : .env, id_rsa).
Contenu : Fichiers contenant des mots-clés sensibles (ex : password=123).

Chemins des fichiers : Localisation des fichiers problématiques.

**⚠️ À faire après le scan :**

1. Vérifier les faux positifs : Certains fichiers peuvent être légitimes (ex : config.test).
2. Corriger les problèmes :
Supprimer ou chiffrer les fichiers sensibles.
Utiliser un coffre-fort de secrets (ex : HashiCorp Vault, AWS Secrets Manager).
3. Documenter les actions : Notez les corrections apportées dans un registre des risques.

___

## Bonnes pratiques

Exécutez le script avec un utilisateur standard (pas besoin de root).
Ne scannez pas de partages réseau (NFS, SMB) sans autorisation.
Adaptez les dictionnaires régulièrement (nouveaux projets, nouveaux outils).
Intégrez le scan dans vos processus :

- Avant un audit interne.  
-  Après un incident de sécurité.  
- Lors de la sensibilisation des équipes.  

---

## FAQ
Q : Le script ralentit-il mon poste ?
R : L'impact dépend du volume de fichiers analysés et du support de stockage. Le script utilise des commandes système standards (find, grep, file).
Q : Puis-je l’utiliser sur un serveur ?
R : Oui, mais vérifiez que les droits d’accès sont suffisants pour scanner les répertoires cibles.
Q : Comment éviter les faux positifs ?
R : Affinez les dictionnaires (patterns.txt, fichiers_sensibles.txt) pour exclure les fichiers légitimes.

---

## Licence

Le code de ce dépôt (`audit_hygiene.sh` et scripts associés) est distribué sous licence **MIT**.

Les fichiers de configuration et dictionnaires (`patterns.txt`, `fichiers_sensibles.txt`) sont fournis à titre d'exemples et peuvent être librement adaptés à votre contexte organisationnel.

Voir le fichier [`LICENSE`](./LICENSE-MIT) pour les termes complets.

© 2026 Solène Figueiredo
