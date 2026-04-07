#!/usr/bin/env bash
# Install git hooks for this project.
# Usage: bash scripts/install-hooks.sh

HOOKS_DIR="$(git rev-parse --git-dir)/hooks"
PRE_PUSH="$HOOKS_DIR/pre-push"

cat > "$PRE_PUSH" << 'HOOK'
#!/usr/bin/env bash
# pre-push hook: update commit-info.json with the latest commit hash before pushing.

COMMIT_HASH=$(git rev-parse --short HEAD)
JS_FILE="commit-info.js"

echo "// Auto-updated by pre-push hook — do not edit manually." > "$JS_FILE"
echo "var COMMIT_HASH = \"$COMMIT_HASH\";" >> "$JS_FILE"
git add "$JS_FILE"
git commit --amend --no-edit

echo "Updated $JS_FILE with commit $COMMIT_HASH"
HOOK

chmod +x "$PRE_PUSH"
echo "Installed pre-push hook to $PRE_PUSH"
