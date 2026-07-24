#!/usr/bin/env bash

set -o pipefail

# ==========================================================
# Audit d'hygiène numérique
# Détecteur de fichiers sensibles
# ==========================================================

# Répertoire où se trouve ce script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PATTERNS_FILE="$SCRIPT_DIR/patterns.txt"
SENSITIVE_FILES_FILE="$SCRIPT_DIR/fichiers_sensibles.txt"

OUTPUT_FORMAT="txt"
REPORT_FILE="audit_report_$(date +%F).txt"
TARGET_DIR="."

TOTAL_FILES=0
declare -a ALERTS

# ----------------------------------------------------------
# Vérifications
# ----------------------------------------------------------

[[ -f "$PATTERNS_FILE" ]] || {
    echo "Erreur : $PATTERNS_FILE introuvable."
    exit 1
}

[[ -f "$SENSITIVE_FILES_FILE" ]] || {
    echo "Erreur : $SENSITIVE_FILES_FILE introuvable."
    exit 1
}

# ----------------------------------------------------------
# Arguments
# ----------------------------------------------------------

while [[ $# -gt 0 ]]; do
    case "$1" in
        --csv)
            OUTPUT_FORMAT="csv"
            REPORT_FILE="audit_report_$(date +%F).csv"
            shift
            ;;

        --output)
            REPORT_FILE="$2"
            shift 2
            ;;

        -*)
            echo "Option inconnue : $1"
            exit 1
            ;;

        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

[[ -d "$TARGET_DIR" ]] || {
    echo "Erreur : répertoire introuvable : $TARGET_DIR"
    exit 1
}

# ----------------------------------------------------------
# Chargement des dictionnaires
# ----------------------------------------------------------

PATTERNS=()
while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" ]] && continue
    PATTERNS+=("$line")
done < "$PATTERNS_FILE"

SENSITIVE_FILES=()
while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" ]] && continue
    SENSITIVE_FILES+=("$line")
done < "$SENSITIVE_FILES_FILE"

# ----------------------------------------------------------
# Fonction de scan
# ----------------------------------------------------------

scan_file() {

    local file="$1"
    local filename
    filename=$(basename "$file")

    local alert_type=""
    local alert_content=""

    # -------------------------
    # Nomenclature
    # -------------------------

    for sensitive in "${SENSITIVE_FILES[@]}"; do

        [[ -z "$sensitive" ]] && continue

        if [[ "$filename" == "$sensitive" ]]; then

            alert_type="Nomenclature"
            alert_content="Nom sensible : $filename"

            ALERTS+=("$file|$alert_type|$alert_content")
            break

        fi

    done

    # -------------------------
    # Vérifie que le fichier est texte
    # -------------------------

    if file -b --mime-encoding "$file" | grep -Eq 'utf-8|us-ascii|ascii'; then

        for pattern in "${PATTERNS[@]}"; do

            [[ -z "$pattern" ]] && continue

            if grep -Eiq "$pattern" "$file"; then

                alert_type="Contenu"
                alert_content="Pattern détecté : $pattern"

                ALERTS+=("$file|$alert_type|$alert_content")

                return

            fi

        done

    fi

}

# ----------------------------------------------------------
# Scan
# ----------------------------------------------------------

echo
echo "==============================================="
echo " Audit d'hygiène numérique"
echo "==============================================="
echo "Répertoire : $TARGET_DIR"
echo

while IFS= read -r file; do

    ((TOTAL_FILES++))

    scan_file "$file"

done < <(find "$TARGET_DIR" -type f 2>/dev/null)

# ----------------------------------------------------------
# Génération TXT
# ----------------------------------------------------------

if [[ "$OUTPUT_FORMAT" == "txt" ]]; then

    {

        echo "=========================================="
        echo " Rapport d'audit"
        echo "=========================================="
        echo "Date : $(date)"
        echo
        echo "Répertoire analysé : $TARGET_DIR"
        echo
        echo "Nombre de fichiers : $TOTAL_FILES"
        echo "Alertes détectées  : ${#ALERTS[@]}"
        echo

        if [[ ${#ALERTS[@]} -gt 0 ]]; then

            echo "---------- ALERTES ----------"

            for alert in "${ALERTS[@]}"; do
                IFS="|" read -r path type content <<< "$alert"

                echo
                echo "[$type]"
                echo "$path"
                echo "$content"

            done

        else

            echo "Aucune alerte."

        fi

    } > "$REPORT_FILE"

fi

# ----------------------------------------------------------
# Génération CSV
# ----------------------------------------------------------

if [[ "$OUTPUT_FORMAT" == "csv" ]]; then

    echo '"Chemin","Nom","Type","Description"' > "$REPORT_FILE"

    for alert in "${ALERTS[@]}"; do

        IFS="|" read -r path type content <<< "$alert"

        content=${content//\"/\"\"}

        echo "\"$path\",\"$(basename "$path")\",\"$type\",\"$content\"" \
            >> "$REPORT_FILE"

    done

fi

# ----------------------------------------------------------
# Résumé console
# ----------------------------------------------------------

echo
echo "-------------------------------------------"
echo "Fichiers analysés : $TOTAL_FILES"
echo "Alertes détectées : ${#ALERTS[@]}"
echo "Rapport généré    : $REPORT_FILE"
echo "-------------------------------------------"