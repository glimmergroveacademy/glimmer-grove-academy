#!/usr/bin/env bash
set -euo pipefail

PRIMARY_DIR="${PRIMARY_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
SECONDARY_DIR="${SECONDARY_DIR:-$(cd "$PRIMARY_DIR/../blog-en" && pwd)}"
PREFIX="${PREFIX:-en}"

if [[ "$PREFIX" == "." || "$PREFIX" == ".." || "$PREFIX" == */* ]]; then
  echo "PREFIX must be a single directory name, such as en." >&2
  exit 2
fi

for site in "$PRIMARY_DIR" "$SECONDARY_DIR"; do
  if [[ ! -f "$site/_config.yml" ]]; then
    echo "Not a Hexo site: $site (_config.yml missing)" >&2
    exit 1
  fi
done

run_hexo() {
  local site="$1"
  local command="$2"
  (
    cd "$site"
    if command -v npx >/dev/null 2>&1; then
      npx hexo "$command"
    elif command -v hexo >/dev/null 2>&1; then
      hexo "$command"
    else
      echo "Hexo CLI not found. Run npm install in both sites first." >&2
      exit 1
    fi
  )
}

echo "Building Chinese primary site: $PRIMARY_DIR"
run_hexo "$PRIMARY_DIR" clean
run_hexo "$PRIMARY_DIR" generate

echo "Building English secondary site: $SECONDARY_DIR"
run_hexo "$SECONDARY_DIR" clean
run_hexo "$SECONDARY_DIR" generate

if [[ ! -d "$SECONDARY_DIR/public" ]]; then
  echo "English build did not create $SECONDARY_DIR/public" >&2
  exit 1
fi

MERGED_DIR="$PRIMARY_DIR/public/$PREFIX"
rm -rf "$MERGED_DIR"
mkdir -p "$MERGED_DIR"
cp -R "$SECONDARY_DIR/public/." "$MERGED_DIR/"

echo "Merged English output into: $MERGED_DIR"

test -f "$PRIMARY_DIR/public/index.html"
test -f "$PRIMARY_DIR/public/$PREFIX/index.html"

echo "Verified final structure:"
echo "  $PRIMARY_DIR/public/index.html"
echo "  $PRIMARY_DIR/public/$PREFIX/index.html"
echo "Do not run Hexo clean/generate in $PRIMARY_DIR after this merge unless you rebuild with this script."
