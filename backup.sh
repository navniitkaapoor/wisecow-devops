#!/bin/bash

SOURCE_DIR="/home/nave/projects"

BACKUP_NAME="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
BACKUP_PATH="/tmp/$BACKUP_NAME"

REMOTE_USER="ubuntu"
REMOTE_HOST="13.233.107.138"
REMOTE_DIR="/home/ubuntu/backups"
KEY_PATH="my_test_server.pem"

LOG_FILE="./backup_report.log"

echo "===== Backup Started: $(date) =====" >> "$LOG_FILE"

tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

if [ $? -eq 0 ]
then
    echo "Backup file created successfully: $BACKUP_NAME" >> "$LOG_FILE"

    scp -i "$KEY_PATH" "$BACKUP_PATH" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"

    if [ $? -eq 0 ]
    then
        echo "SUCCESS: Backup copied to EC2 server" | tee -a "$LOG_FILE"
    else
        echo "FAILED: Backup could not be copied to EC2 server" | tee -a "$LOG_FILE"
    fi
else
    echo "FAILED: Backup file was not created" | tee -a "$LOG_FILE"
fi

echo "===== Backup Completed: $(date) =====" >> "$LOG_FILE"
