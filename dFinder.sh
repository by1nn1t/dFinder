#!/bin/bash

scandir() {
  baseurl="$1"
  wordlist="$2"

  while IFS= read -r directory; do
    url="$baseurl/$directory"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    if [ "$response" -eq 200 ]; then
      echo -e "\e[32m[+] \e[32mDirectory \e[32mfound\e[0m: $url"
    else
      echo -e "\e[91m[+] \e[91mDirectory \e[91mnot \e[91mfound\e[0m: $url"
    fi
  done < "$wordlist"
}

main() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: $0 ./dircrawler.sh <baseurl> <wordlist>"
    exit 1
  fi

  baseurl="$1"
  wordlist="$2"

  if [ ! -f "$wordlist" ]; then
    echo "Wordlist not found: $wordlist"
    exit 1
  fi

  if ! command -v curl &> /dev/null; then
    echo "curl is required but not installed. Please install curl."
    exit 1
  fi

  scandir "$baseurl" "$wordlist"
}

cat << "EOF"
 ____  ____  __  __ _  ____  ____  ____ 
(    \(  __)(  )(  ( \(    \(  __)(  _ \
 ) D ( ) _)  )( /    / ) D ( ) _)  )   /
(____/(__)  (__)\_)__)(____/(____)(__\_)

                                                   by 1nn1t

EOF

main "$@"
