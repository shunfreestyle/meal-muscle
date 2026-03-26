#!/bin/bash
cd "$(dirname "$0")"

echo "👀 index.html を監視中... (Ctrl+C で停止)"

fswatch -0 index.html | while read -d '' event; do
  sleep 1
  if git diff --quiet && git diff --cached --quiet; then
    continue
  fi
  git add .
  git commit -m "auto: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
  echo "✅ push完了 — $(date '+%H:%M:%S')"
done
