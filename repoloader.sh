#!/bin/bash

# Check if directory argument is provided 
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Default ignored extensions 
IGNORE_EXTS=()

# If first argument passed, use it as ignore extensions
if [ $# -gt 0 ]; then
  IGNORE_EXTS=(${1//,/ })
  shift
fi  

# Get directory from first argument
DIR="$1"

# Find all text files recursively, excluding hidden dirs
find "$DIR" -type d -name '.*' -prune -o -type f -print0 | while IFS= read -r -d '' FILE; do

  # Get extension
  EXT="${FILE##*.}"
  # Check if extension should be ignored
  if [[ " ${IGNORE_EXTS[@]} " =~ " ${EXT} " ]]; then
    continue
  fi 
  # Check MIME type
  MIMETYPE=$(file -b --mime-type "$FILE")

  # Check if text
  if [[ $MIMETYPE == text* ]]; then 
    REL_FILE="${FILE#$DIR/}"
    echo ""
    echo "Contents of \`$REL_FILE\`:"
    echo "\`\`\`"
    cat "$FILE" | nl
    echo ""
    echo "\`\`\`"
    echo "-"
  fi

done