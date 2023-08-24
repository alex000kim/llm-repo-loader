#!/bin/bash

# Function to print usage
usage() {
  echo "Usage: $0 --include=<extensions> --ignore-dirs=<directories to ignore> <input directory>"
  exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -lt 3 ]; then
  usage
fi

# Parse the command-line arguments
INCLUDE=""
IGNORE_DIRS=""
INPUT_DIR=""

for arg in "$@"; do
  case $arg in
    --include=*)
      INCLUDE="${arg#*=}"
      ;;
    --ignore-dirs=*)
      IGNORE_DIRS="${arg#*=}"
      ;;
    *)
      if [ -z "$INPUT_DIR" ]; then
        INPUT_DIR="$arg"
      else
        echo "Multiple input directories provided."
        usage
      fi
      ;;
  esac
done

# Check if the input directory is provided
if [ -z "$INPUT_DIR" ]; then
  echo "Input directory not provided."
  usage
fi

# Check if the include extensions are provided
if [ -z "$INCLUDE" ]; then
  echo "Include extensions not provided."
  usage
fi

# Convert comma-separated extensions and ignore directories into arrays
IFS=',' read -ra EXTENSIONS <<< "$INCLUDE"
IFS=',' read -ra IGNORE <<< "$IGNORE_DIRS"

# Function to print the contents of files with specified extensions
print_contents() {
  local dir="$1"
  for ext in "${EXTENSIONS[@]}"; do
    find "$dir" -type f ! -path '*/\.*' \( -name "*.$ext" \) -print0 | while IFS= read -r -d '' file; do
      # Check if the file is in one of the ignored directories
      for ignore_dir in "${IGNORE[@]}"; do
        if [[ $file == "$ignore_dir"* ]]; then
          continue 2
        fi
      done
      echo "Contents of \`$file\`:"
      echo ">>>>"
      cat "$file"
      echo "<<<<"
      echo ""
    done
  done
}

# Call the function with the input directory
print_contents "$INPUT_DIR"
