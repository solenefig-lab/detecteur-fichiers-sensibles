#!/bin/bash
echo "=== AUDIT FICHIERS SENSIBLES ==="
echo "Date : $(date)"
echo "Dossier analysé : $1"
echo "================================"

grep -rEi "password|secret|token|confidentiel|clé|pwd" "$1" --include="*.txt" --include="*.csv" --include="*.md"

echo "================================"
echo "Audit terminé."
