#!/usr/bin/env bash
#
# Bootstraps the library dependency for this repo. Run it after cloning this
# repo on a new machine — the 86 jars live in a separate Berkeley repo and are
# gitignored here (see "# Library / *.jar" in .gitignore).
#
# Clones library-sp26 as a SIBLING of this repo, never inside it. The course is
# explicit ("We do not want these folders nested!") and every path here —
# ../library-sp26 in build.gradle, .idea/libraries/, and the cs61b script —
# assumes that layout:
#
#   Github/
#   |-- library-sp26/   <- jars
#   `-- CS61B/          <- this repo
#
# Safe to re-run: an existing clone is updated rather than replaced.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "${REPO_DIR}/.." && pwd)/library-sp26"
LIBRARY_URL="https://github.com/Berkeley-CS61B/library-sp26.git"
SKELETON_URL="https://github.com/Berkeley-CS61B/skeleton-sp26.git"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
die()  { printf '\033[1;31m[x]\033[0m %s\n' "$1" >&2; exit 1; }

command -v git  >/dev/null 2>&1 || die "git not found (macOS: xcode-select --install)."
command -v java >/dev/null 2>&1 || die "java not found. CS 61B sp26 uses JDK 25."

info "Detected JDK $(java -version 2>&1 | sed -n 's/.*version "\([0-9]*\).*/\1/p' | head -1)"

if [ -d "${LIB_DIR}/.git" ]; then
  info "library-sp26 present, pulling latest..."
  git -C "$LIB_DIR" pull --ff-only || info "pull skipped (local changes?)"
elif [ -e "$LIB_DIR" ]; then
  die "${LIB_DIR} exists but is not a git repo. Move or delete it, then re-run."
else
  info "Cloning library-sp26 -> ${LIB_DIR}"
  git clone "$LIBRARY_URL" "$LIB_DIR"
fi

# The 'skeleton' remote is how new assignment folders arrive:  git pull skeleton main
if ! git -C "$REPO_DIR" remote get-url skeleton >/dev/null 2>&1; then
  git -C "$REPO_DIR" remote add skeleton "$SKELETON_URL"
  info "Added 'skeleton' remote."
fi

info "$(find "$LIB_DIR" -maxdepth 1 -name '*.jar' | wc -l | tr -d ' ') jars ready at ${LIB_DIR}"
info "Next: ./configure-intellij.sh, then open this folder in IntelliJ."
