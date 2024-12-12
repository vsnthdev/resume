#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_to_watch>"
    echo "Example: $0 resume.tex"
    exit 1
fi

# Store the file to watch
WATCH_FILE="$1"

# Check if file exists
if [ ! -f "$WATCH_FILE" ]; then
    echo "Error: File '$WATCH_FILE' does not exist."
    exit 1
fi

LC_ALL=en_US.UTF-8 lualatex "$WATCH_FILE"