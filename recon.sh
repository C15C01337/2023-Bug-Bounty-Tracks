#!/bin/bash

# Check if the required tools (naabu, whois, waybackurls, httpx) are installed
if ! command -v naabu &> /dev/null; then
    echo "Error: naabu is not installed. Please install it and try again."
    exit 1
fi

if ! command -v whois &> /dev/null; then
    echo "Error: whois is not installed. Please install it and try again."
    exit 1
fi

if ! command -v waybackurls &> /dev/null; then
    echo "Error: waybackurls is not installed. Please install it and try again."
    exit 1
fi

if ! command -v httpx &> /dev/null; then
    echo "Error: httpx is not installed. Please install it and try again."
    exit 1
fi

# Take target URL as input
read -p "Enter target URL or IP: " target

# Port scan using naabu
echo "Running naabu port scan on $target..."
naabu -h $target -o naabu-output.txt

# Whois lookup
echo "Running whois lookup on $target..."
whois $target > whois-output.txt

# Wayback machine URL discovery
echo "Running wayback machine URL discovery on $target..."
waybackurls $target > wayback-output.txt

# HTTP request scanner
echo "Running httpx scan on $target..."
httpx -threads 100 -follow-redirects -status-code -t 1000 $target -o httpx-output.txt

echo "Scan completed."
