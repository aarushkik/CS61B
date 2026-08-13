#!/usr/bin/env bash
#
# Generates IntelliJ IDEA project files for the CS 61B sp26 workspace.
#
# This is the same configuration the official course instructions have you build
# by hand through File > Project Structure, except it covers every assignment at
# once instead of repeating the setup per folder:
#
#   Project    -> SDK + language level + compiler output
#   Libraries  -> "cs61b-library-sp26", a jar-directory pointing at ../library-sp26
#   Modules    -> one module per assignment; src/ marked Sources, tests/ marked Tests
#
# Re-run it after 'git pull skeleton main' adds a new assignment folder.
#
# Usage:  ./configure-intellij.sh [jdk-name] [language-level]
#           jdk-name        as it appears in IntelliJ's SDK list (default: 26)
#           language-level  e.g. JDK_25, JDK_26 (default: JDK_25, matching the course)

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JDK_NAME="${1:-26}"
LANG_LEVEL="${2:-JDK_25}"
LIBRARY_NAME="cs61b-library-sp26"
LIBRARY_PATH="\$PROJECT_DIR\$/../library-sp26"

cd "$REPO_DIR"

if [ ! -d "../library-sp26" ]; then
  echo "[x] ../library-sp26 not found. Run setup-cs61b.sh first." >&2
  exit 1
fi

# An assignment is any top-level folder containing src/.
ASSIGNMENTS=()
for dir in */; do
  name="${dir%/}"
  [ -d "${name}/src" ] || continue
  ASSIGNMENTS+=("$name")
done

if [ ${#ASSIGNMENTS[@]} -eq 0 ]; then
  echo "[x] No assignment folders found (expected e.g. hw01/src)." >&2
  exit 1
fi

mkdir -p .idea/libraries

# --- Project: SDK, language level, compiler output ---------------------------

cat > .idea/misc.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ProjectRootManager" version="2" languageLevel="${LANG_LEVEL}" default="true" project-jdk-name="${JDK_NAME}" project-jdk-type="JavaSDK">
    <output url="file://\$PROJECT_DIR\$/out" />
  </component>
</project>
EOF

cat > .idea/compiler.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="CompilerConfiguration">
    <bytecodeTargetLevel target="25" />
  </component>
</project>
EOF

# --- Library: the whole library-sp26 folder ----------------------------------
#
# jarDirectory (rather than listing 86 <root> entries) means IntelliJ rescans the
# folder, so 'git pull' in library-sp26 picks up new jars with no edits here.

cat > ".idea/libraries/${LIBRARY_NAME//-/_}.xml" <<EOF
<component name="libraryTable">
  <library name="${LIBRARY_NAME}">
    <CLASSES>
      <root url="file://${LIBRARY_PATH}" />
    </CLASSES>
    <JAVADOC />
    <SOURCES />
    <jarDirectory url="file://${LIBRARY_PATH}" recursive="false" />
  </library>
</component>
EOF

# --- Modules: one per assignment ---------------------------------------------

{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<project version="4">'
  echo '  <component name="ProjectModuleManager">'
  echo '    <modules>'
  for name in "${ASSIGNMENTS[@]}"; do
    echo "      <module fileurl=\"file://\$PROJECT_DIR\$/${name}/${name}.iml\" filepath=\"\$PROJECT_DIR\$/${name}/${name}.iml\" />"
  done
  echo '    </modules>'
  echo '  </component>'
  echo '</project>'
} > .idea/modules.xml

for name in "${ASSIGNMENTS[@]}"; do
  # tests/ only exists for some assignments (hw02 has none).
  test_root=""
  if [ -d "${name}/tests" ]; then
    test_root="      <sourceFolder url=\"file://\$MODULE_DIR\$/tests\" isTestSource=\"true\" />"
  fi

  cat > "${name}/${name}.iml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="false">
    <output url="file://\$MODULE_DIR\$/../out/production/${name}" />
    <output-test url="file://\$MODULE_DIR\$/../out/test/${name}" />
    <exclude-output />
    <content url="file://\$MODULE_DIR\$">
      <sourceFolder url="file://\$MODULE_DIR\$/src" isTestSource="false" />
${test_root}
    </content>
    <orderEntry type="inheritedJdk" />
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="${LIBRARY_NAME}" level="project" />
  </component>
</module>
EOF
done

echo "==> Configured ${#ASSIGNMENTS[@]} modules: ${ASSIGNMENTS[*]}"
echo "==> SDK '${JDK_NAME}', language level ${LANG_LEVEL}, library '${LIBRARY_NAME}' -> ../library-sp26"
echo
echo "Now open ${REPO_DIR} in IntelliJ (File > Open, pick the folder itself)."
echo "If it was already open: File > Reload Project from Disk."
