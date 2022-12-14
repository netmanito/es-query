#!/bin/bash
# set -e
# set -o pipefail
set -u

USAGE="Usage: bash install.sh run"
# EXPECTED?=1

ES_QUERY_DIR="${HOME}/.es-query"
ES_QUERY="${HOME}/bin/es-query"
ROOT_DIR="${PWD}"

BASH_COMP="$(ls -las "${HOME}"/.es-query/es-query_bash_completion)"

function diffComp {
        diff es-query_bash_completion "${HOME}"/.es-query/es-query_bash_completion
}

ENV_ME=$(
        cat <<EOF >>~/.es-query/.env
        USERNAME="elastic"
        PASSWORD="changeme"
        URL="localhost:9200"
EOF
)

if [ ! -f "$ES_QUERY" ]; then
        echo "es-query not installed"
        $ES_QUERY
        if [ -z "$ES_QUERY_DIR" ]; then
                if [ "${PWD}" == "${HOME}" ]; then
                        echo "No .es-query directory found, creating it for you."
                        echo "..."
                        mkdir .es-query
                else 
                        echo "No .es-query directory found, creating it for you."
                        echo "..."
                        mkdir "${HOME}"/.es-query
                fi
        fi
        echo "Copying files to directory"
        if [ ! -f "${HOME}/.es-query/.env" ]; then
                echo ".env file not found, creating one for you."
                $ENV_ME
        else 
                echo ".env file found, not adding it."
        fi
        echo "Installing es-query"
        cp es-query "${HOME}"/bin/
        chmod +x "${HOME}"/bin/es-query
        echo "es-query installed"
        echo "Installing es-query bash completion"
        if [ -z "$BASH_COMP" ]; then
                cp es-query_bash_completion "${HOME}"/.es-query/
        fi
        echo "All Done!!"
else
        echo "es-query found on your ~/bin directory"
        echo "Do you want to update?"
        read -p "Press ENTER to continue"
        echo "Updating es-query"
        mv "${HOME}"/bin/es-query{,.old}
        cp es-query "${HOME}"/bin/es-query
        chmod +x "${HOME}"/bin/es-query
        echo "Checking associated files"
        if [ -z "$ES_QUERY_DIR" ]; then
                echo ".es-query directory not found, creating one for you"
                mkdir "${HOME}"/.es-query
                echo "Copying files to directory"
                $ENV_ME
                cp es-query_bash_completion "${HOME}"/.es-query/
        else
                echo ".es-query directory found"
                echo "Checking differences in es-query_bash_completion"
                EXISTS=$(diffComp)
                if [ -z "$EXISTS" ]; then
                        if [ -z "$BASH_COMP" ]; then
                        cp es-query_bash_completion "${HOME}"/.es-query/
                        fi
                else 
                        echo "Differences found on es-query_bash_completion file."
                        echo  -p "Do you want to update? Press ENTER to continue"
                        mv "${HOME}"/.es-query/es-query_bash_completion{,.old}
                        cp es-query_bash_completion "${HOME}"/.es-query/
                        echo "old es-query_bash_completion was moved to .old"
                        echo "new es-query_bash_completion installed"
                fi
        fi
        echo "es-query Successfully updated"
        echo "All Done!!"
fi

