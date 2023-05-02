#!/bin/bash

# Define formatting.
check='\xE2\x9C\x94'
cross='\xE2\x9D\x8C'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
pymakr_config_path='~/.config/Code/User'
pymakr_config_url=''

# Check if the given install was successful
function did_succeed() {
    # Check if the file is empty
    if [ -s error ]; then
        echo -e "${RED}${cross}An error occurred $1${NC}"
        cat error
        exit -1
    else
        echo -e "${GREEN}${check}Successfully ran $1${NC}"
    fi
}


sudo apt-get update && sudo apt-get upgrade -y 2>error
did_succeed "Updating Packages"
code_deb="code_1.77.3-1681292746_amd64.deb"
wget -O $code_deb https://go.microsoft.com/fwlink/?LinkID=760868 2>deb_status
# Technically not a real check here, TODO(morleyd): Fix to proper check
did_succeed "Fetching Code File "
sudo apt-get install ./$code_deb -y 2>error
did_succeed "Installing Code"
sudo apt-get install nodejs 2>error
did_succeed "Installing NodeJs"
code --install-extension pycom.pymakr@1.1.18 2>error
did_succeed "Installing PyMakr Extension"
wget -O ${pymakr_config_path}/pymakr.json ${pymakr_config_url} 2>error
did_succeed "Copy PyMakr Config"

# If we get here, than everything successfully ran, so remove our tmp files.
rm deb_status error
