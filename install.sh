#!/bin/bash
# set -e
# set -o pipefail
# set -u

ES_QUERY="${HOME}/.es-query/esq"
ES_QUERY_DIR="${HOME}/.es-query"
BASH_COMP="${HOME}/.es-query/es-query_bash_completion"
ENV_FILE="${HOME}/.es-query/.env"

function env_me {
        ENV_ME=$(
                cat <<EOF >>~/.es-query/.env
        USERNAME="elastic"
        PASSWORD="changeme"
        URL="localhost:9200"
EOF
        )
        $ENV_ME
}

function bash_me {
        BASH_ME=$(
                cat <<EOF >>~/.bashrc
   export PATH="$PATH:$ES_QUERY_DIR" 
EOF
        )
        $BASH_ME
}

# Check if bash_me is configured in .bashrc
esq_check() {
        grep -q es-query "${HOME}"/.bashrc
        return $?
}

function checkBC {
        diff es-query_bash_completion "${ES_QUERY_DIR}"/es-query_bash_completion
}

function checkDir {
        if [ -d "$ES_QUERY_DIR" ]; then
                echo "++++++++++++++++++++++++++++++++++++"
                echo ".es-query Directory Found"
                echo "Checking differences in es-query_bash_completion"
                if [[ -f "$BASH_COMP" ]]; then
                        echo "query_bash_completion found"
                        echo "checking changes"
                        DIFF=$(checkBC)
                        if [ -z "$DIFF" ]; then
                                echo "No changes found, nothing to do"
                        else
                                echo "$DIFF"
                                echo "Do you want to Update?"
                                read -p "Press Enter to continue"
                        # mv "${HOME}"/.es-query/es-query_bash_completion{,.old}
                        # cp es-query_bash_completion "${HOME}"/.es-query/
                        fi
                else
                        echo "query_bash_completion File does not exist, not comparing"
                        # cp es-query_bash_completion "${HOME}"/.es-query/
                fi
                echo "++++++++++++++++++++++++++++++++++++"
                echo "Checking .env file"
                if [[ -f "$ENV_FILE" ]]; then
                        echo ".env file found, doing nothing"
                else
                        echo ".env file Not found, creating ..."
                        env_me
                        echo "Done"
                fi
        else
                echo "------------------------------------"
                echo "Checking for .es-query Directory"
                echo ".es-query directory not found, creating one for you"
                read -p "Press ENTER to Continue"
                echo "..."
                mkdir "${ES_QUERY_DIR}"
                echo ".es-query directory created in your HOME"
                echo "======================================================"
                echo "Copying necessary files to .es-query directory"
                env_me
                cp es-query_bash_completion "${ES_QUERY_DIR}"/
                echo "Done ..."
                bash_me
                echo ""
                echo "======================================================"
                echo ""
                echo "ES-Query resources installed"
        fi
}

if [ ! -f "$ES_QUERY" ]; then
        echo "======================================================"
        echo "ES-Query NOT Installed"
        read -p "Press ENTER to continue Install or CRTL+C to abort"
        echo "======================================================"
        checkDir
        echo "Installing ES-Query"
        cp esq "${ES_QUERY_DIR}"/
        chmod +x "${ES_QUERY_DIR}"/esq
        echo "ES-Query installed"
        if [ $? -eq 0 ]; then
                echo "es-query already in .bashrc"
                echo "No changes needed"
        else
                echo "bash_me not found in .bashrc"
                echo "Configuring ..."
        fi
        echo "All Done!!"
else
        echo "======================================================"
        echo "ES-Query found on your ~/bin directory"
        echo "Do you want to update?"
        echo ""
        read -p "Press ENTER to continue or CRTL+C to abort"
        echo ""
        echo "Updating ES-Query"
        mv "${ES_QUERY_DIR}"/esq{,.old}
        cp esq "${ES_QUERY_DIR}"/esq
        chmod +x "${ES_QUERY_DIR}"/esq
        rm "${ES_QUERY_DIR}"/esq.old
        echo ""
        echo "Update Done"
        echo ""
        echo "======================================================"
        echo "ES-Query Successfully updated"
        checkDir
        echo ""
        echo "All Done!!"
fi
