#!/bin/bash

# Configuration
TARGET_DIR=${1:-$HOME} # Analyse le Home par défaut
PATTERNS=$(cat patterns.txt)
REPORT_FILE="audit_report_$(date +%F).txt"

echo "----------------------------------------------------"
echo "   AUDIT DE PROTECTION DES DONNÉES - LOCALHOST      "
echo "   Date : $(date)"
echo "----------------------------------------------------"

# 1. Collecte des métriques (Le volume)
echo "[*] Calcul des volumes en cours..."
nb_dossiers=$(find "$TARGET_DIR" -type d 2>/dev/null | wc -l)
nb_fichiers=$(find "$TARGET_DIR" -type f 2>/dev/null | wc -l)

# 2. Recherche par noms de fichiers (Exposition technique)
# On utilise la liste créée à l'étape 1
echo "[*] Recherche de fichiers critiques par nomenclature..."
fichiers_nom=$(find "$TARGET_DIR" -type f \( -name ".env" -o -name "config.json" -o -name "id_rsa" -o -name "credentials.xml" \) 2>/dev/null)
count_nom=$(echo "$fichiers_nom" | grep -v '^$' | wc -l)

# 3. Recherche par contenu (Exposition GRC/RGPD)
echo "[*] Analyse des contenus (Patterns sensibles)..."
fichiers_contenu=$(grep -rEil "$PATTERNS" "$TARGET_DIR" \
    --include="*.txt" --include="*.csv" --include="*.md" \
    --include="*.env" --include="config.json" 2>/dev/null)
count_contenu=$(echo "$fichiers_contenu" | grep -v '^$' | wc -l)

# 4. Synthèse pour Revue de Direction (Positionnement GRC)
echo -e "\n==============================================="
echo "               SYNTHÈSE DE L'AUDIT             "
echo "==============================================="
echo "Périmètre analysé    : $TARGET_DIR"
echo "Nombre de dossiers   : $nb_dossiers"
echo "Nombre de fichiers   : $nb_fichiers"
echo "-----------------------------------------------"
echo "ALERTE : Fichiers critiques trouvés (nom) : $count_nom"
echo "ALERTE : Fichiers suspects (contenu)      : $count_contenu"
echo "==============================================="

# 5. Liste détaillée pour revue et modification
echo -e "\n[DÉTAILS POUR PLAN D'ACTION]"
if [ $count_nom -gt 0 ]; then
    echo -e "\n--- Fichiers de config/secrets identifiés ---"
    echo "$fichiers_nom"
fi

if [ $count_contenu -gt 0 ]; then
    echo -e "\n--- Documents contenant des mots-clés sensibles ---"
    echo "$fichiers_contenu"
fi

echo -e "\nFin de l'audit."
