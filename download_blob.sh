#!/bin/bash



# Authentication token from GitHub CLI
TOKEN=$(gh auth status --show-token | grep Token: | cut -d ' ' -f5)

echo $TOKEN
# Directory where you want to save the downloaded files
DESTINATION_DIR="./data/downloaded_blobs"

# Create the destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

# Read each line in the file
while IFS= read -r line; do


    url="${line//$'\r'/}"
    echo "URL after removing carriage return: $url<-"

    #extract repo name
    REPO=$(echo $url | cut -d '/' -f5) 

    echo "Repo name: $REPO"

    # Extract the file name from the URL
    FILENAME=$(basename "$url")
    echo "Filename to be downloaded: $FILENAME"

    # Use curl to download the file
    set -x
    curl -H "Authorization: token $TOKEN" -L "$url" -o "$DESTINATION_DIR/${REPO}__$FILENAME"
done < "./data/blob_urls.txt"	