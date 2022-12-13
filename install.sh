#!/bin/bash

ES_QUERY_DIR="${HOME}/.es-query"
ES_QUERY="${HOME}/bin/es-query"

function diffComp {
        diff es-query_bash_completion "${HOME}"/.es-query/es-query_bash_completion
}

BASH_ME=$(
        cat <<EOF >>~/.bashrc
   if [ -f ~/.bash_me ]; then
        source ~/.bash_me
   fi
EOF
)

if [ -z "$ES_QUERY" ]; then
        echo "es-query not installed"
        $ES_QUERY
        echo "Downloading es-query"
        if [[ -f "es-query" ]]; then
                curl -O https://raw.githubusercontent.com/netmanito/es-query/es-query
        fi 
        echo "No .es-query directory found, creating it for you"
        echo "..."
        if [ "${PWD}" == "${HOME}" ]; then
                mkdir .es-query
        else 
        mkdir "${HOME}"/.es-query
        fi
        echo "Copying files to directory"
        cp .env "${HOME}"/.es-query/
        cp es-query_bash_completion "${HOME}"/.es-query/
        echo "Installing es-query"
        cp es-query ${HOME}/bin/
        chmod +x ${HOME}/bin/es-query
        echo "es-query installed"
        echo "All Done!!"
else
        echo "es-query found on your ~/bin directory"
        if [ -z "$ES_QUERY_DIR" ]; then
                echo ".es-query directory not found, creating one for you"
                mkdir "${HOME}"/.es-query
                echo "Copying files to directory"
                cp .env "${HOME}"/.es-query/
                cp es-query_bash_completion "${HOME}"/.es-query/
        fi
        echo "Do you want to update?"
        read -p "Press ENTER to continue"
        echo "Updating es-query"
        cp es-query "${HOME}"/bin/es-query
        chmod +x "${HOME}"/bin/es-query
        echo "Updating .es-query"
        EXISTS=$(diffComp)
        if [ -z "$EXISTS" ]; then
                exit 0
        else 
                echo "Differences found on es-query_bash_completion file."
                echo  -p "Do you want to update? Press ENTER to continue"
                mv "${HOME}"/.es-query/es-query_bash_completion{,.old}
                cp es-query_bash_completion "${HOME}"/.es-query/
                echo "old es-query_bash_completion was moved to .old"
                echo "new es-query_bash_completion installed"
        fi
        echo "es-query Successfully updated"
        echo "All Done!!"
fi

