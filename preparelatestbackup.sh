#!/bin/bash
date
# Variables
echo "Removing current latest.tar.gz version"
rm /home/opc/backups/latest.tar.gz

date
source_file=$(ls -t /home/opc/backups/ | head -n 1)
echo "Copying $source_file to latest.tar.gz"
cp -f "/home/opc/backups/$source_file" "/home/opc/backups/latest.tar.gz"

