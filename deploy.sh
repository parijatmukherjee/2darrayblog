#!/bin/bash

# Define the port to check
PORT=3000

# Find the PID of the process using the specified port
PID=$(lsof -t -i:$PORT)

# Define the directory where the site files should be copied
WEB_DIR=/home/parijat/2darrayblog/public

# Define the temporary directory for uploading
TEMP_DIR=/tmp/hugo_deploy

# Create the temporary directory if it doesn't exist
mkdir -p $TEMP_DIR

# Clean the temporary directory
rm -rf $TEMP_DIR/*

# Extract the new files to the temporary directory
tar -xzf /tmp/hugo_site.tar.gz -C $TEMP_DIR

# Sync the files to the web directory
rsync -av --delete $TEMP_DIR/ $WEB_DIR/

# Remove the temporary directory
rm -rf $TEMP_DIR

echo "Deployment completed successfully."

# Check if the PID variable is not empty
if [ -n "$PID" ]; then
  echo "http-server is running on port $PORT with PID $PID. Killing it..."
  kill $PID
  echo "Process killed."
else
  echo "No http-server is running on port $PORT."
fi



npm install -g http-server
nohup http-server -p 3000 --cors  > /dev/null 2>&1 &

echo "Site is running..."
