# llm-repo-loader
## Overview
The `repoloader.sh script takes a directory and dumps the contents of all textual files in the git repository into a plain text file. This text dump can then be used with language learning models. The script can optionally ignore files with certain extensions.
## Usage
    bash repoloader.sh [ignored_extensions] <directory>
The ignored_extensions argument is optional and should be a comma-separated list of file extensions to ignore (without the dot). If provided, any files with these extensions will be skipped.
The directory argument is required and should be the path to a directory. All text files within this directory will be parsed and their contents printed.
## Example
Ignore `.md`, `.txt` and `.csv` files:

```bash
wget https://github.com/scikit-learn/scikit-learn/archive/refs/heads/main.zip
unzip main.zip
bash repoloader.sh "md,txt,csv" scikit-learn-main/ > output.txt

```


## Output format
For each text file, the script will print:
- A blank line
- The string: "Contents of \<filename>\:"
- The file contents wrapped in backticks (```)
- A separator line ("-")
The file contents are printed with line numbers. Non-text files and files with the specified ignored extensions are skipped.
