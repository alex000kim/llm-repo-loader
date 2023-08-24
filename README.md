# llm-repo-loader
## Overview
The `repoloader.sh` script takes a directory and prints out the contents of all textual files in the git repository. 
The output can be redirected to a text file.
This text dump can then be used with language learning models. 
The script can optionally ignore certain directories and only include files with certain extensions.

## Usage
```bash
bash repoloader.sh [--include=<extensions>] [--ignore-dirs=<directories>] <directory>
```
### Arguments
- `--include=<extensions>`: A comma-separated list of file extensions to include. If not specified, all files are included.
- `--ignore-dirs=<directories>`: A comma-separated list of directories to ignore. If not specified, no directories are ignored.
- `<directory>`: The directory to search for files. If not specified, the current directory is used.

## Example

```bash
wget https://github.com/scikit-learn/scikit-learn/archive/refs/heads/main.zip
unzip main.zip
bash repoloader.sh --include=md,py,txt \--ignore-dirs=scikit-learn-main/benchmarks,scikit-learn-main/build_tools scikit-learn-main/ > sklearn.txt

```

⚠️ Note: Avoid redirecting the output to a file in the same directory as the repository. This will cause the script to run on the output file as well, resulting in an infinite loop.
