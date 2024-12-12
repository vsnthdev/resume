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

echo "Watching '$WATCH_FILE' for changes..."
echo "Press Ctrl+C to stop watching."

# Store initial modification time
LAST_MODIFIED=$(stat -f %m "$WATCH_FILE")

while true; do
    # Get current modification time
    CURRENT_MODIFIED=$(stat -f %m "$WATCH_FILE")
    
    # If modification time has changed
    if [ "$CURRENT_MODIFIED" != "$LAST_MODIFIED" ]; then
        echo "File changed. Executing lualatex..."
        LC_ALL=en_US.UTF-8 lualatex "$WATCH_FILE"
        
        # Update last modified time
        LAST_MODIFIED=$CURRENT_MODIFIED
    fi
    
    # Sleep for a short time before checking again
    sleep 1
done
