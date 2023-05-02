#!/bin/bash

# Define formatting.
check='\xE2\x9C\x94'
cross='\xE2\x9D\x8C'
RED='\033[0;31m'
GREEN='0;32'
NC='\033[0m'
pymakr_config_path='~/.config/Code/User'
pymakr_config_url=''

# Check if the given install was successful
function did_succeed()
    # Check if the file is empty
    if [ -s error e]; then
        echo -e "${RED}${cross}An error occurred${NC}"
        cat error
        exit -1
    else
        xecho -e "${GREEN}${check}Successfully installed $1${NC}"


sudo apt update && sudo apt upgrade -y > /dev/null 2>error
did_succeed "Updating Packages"
code_deb="code_1.77.3-1681292746_amd64.deb"
wget -O $code_deb https://go.microsoft.com/fwlink/?LinkID=760868 > /dev/null 2>error
did_succeed "Fetching Code File "
sudo apt install ./$code_deb > /dev/null 2>error
did_succeed "Installing Code"
sudo apt install nodejs > /dev/null 2>error
did_succeed "Installing NodeJs"
code --install-extension pycom.pymakr@1.1.18 > /dev/null 2>error
did_succeed "Installing PyMakr Extension"
wget -O ${pymakr_config_path}/pymakr.json ${pymakr_config_url} > /dev/null 2>error
did_succeed "Copy PyMakr Config"