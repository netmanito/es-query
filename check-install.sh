#!/bin/bash

ES_QUERY_DIR="${HOME}/.es-query"
ES_QUERY="${HOME}/bin/esq"

function checkDir {
    if [ -d "$ES_QUERY_DIR" ]; then
        echo "es-query directory found ✅"
    else
        echo "es-query directory not found ❌"
    fi
}

function checkBin {
    ESQ="$(which esq)"
    if [ -f "$ESQ" ]; then
        echo "ES-Query Script found ✅"
        echo ""
        echo $ESQ
    else
        echo "ES-Query Script not found ❌"
    fi
}

function checkCurl {
    CURL="$(which curl)"
    if [ -f "$CURL" ]; then
        echo "Curl found ✅"
        echo ""
        echo $CURL
    else 
        echo "CURL is not installed ❌"
        echo "Install it to use ES-Query"
    fi
}

function checkJq {
    JQ=$(which jq)
    if [ -f "$JQ" ]; then
        echo "Found JQuery ✅"
        echo $JQ
    else
        echo "JQuery is not installed ❌"
        echo "Install it to use ES-Query"
    fi
}

echo "checking directory"
echo "******************"
checkDir
echo "******************"
echo ""
echo "checking script"
echo "******************"
checkBin
echo "******************"
echo ""
echo "checking if Curl is installed"
echo "******************"
checkCurl
echo "******************"
echo ""
echo "checking if JQ is installed"
echo "******************"
checkJq
echo "******************"
echo "All checks Done"
