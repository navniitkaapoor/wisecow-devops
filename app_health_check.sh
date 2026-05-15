#!/bin/bash

URL="https://wisecow.local"

STATUS_CODE=$(curl -k -o /dev/null -s -w "%{http_code}" $URL)

if [ "$STATUS_CODE" -eq 200 ]
then
    echo "Wisecow application is Up"
    echo "Http Status Code: $STATUS_CODE"
else
    echo "Wisecow application is DOWN"
    echo "Http Status Code: $STATUS_CODE"
fi
