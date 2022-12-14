# -------------------------------
# Project Configuration
# -------------------------------
ES_QUERY_DIR="${HOME}/.es-query"
ES_QUERY="${HOME}/bin/es-query"
ROOT_DIR="${PWD}"
# -------------------------------
# Makefile Configuration
# -------------------------------

# -------------------------------
# Makefile Actions
# -------------------------------

info: 
    @echo "es-query Install script"

doctor:
    @echo "Checking installation"


install: info doctor
    @echo "Installing es-query"
	@${ROOT_DIR}/install.sh
clean: 
    @echo "Cleaning Configuration"