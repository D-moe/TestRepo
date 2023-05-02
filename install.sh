#!/bin/bash

# Define formatting.
check='\xE2\x9C\x94'
cross='\xE2\x9D\x8C'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
pymakr_config_path='~/.config/Code/User'
pymakr_config_url='https://raw.githubusercontent.com/D-moe/TestRepo/main/pymakr.json'

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
echo "" > out
echo "Starting Updating Packages, this may take a while"
sudo apt-get update > out && sudo apt-get upgrade -y >> out 2>error
did_succeed "Updating Packages"
# Comment out as install didn't work
#code_deb="code_1.77.3-1681292746_amd64.deb"
#wget -O $code_deb https://go.microsoft.com/fwlink/?LinkID=760868 >> out 2>deb_status
# Technically not a real check here, TODO(morleyd): Fix to proper check
#did_succeed "Fetching Code File "
#sudo apt-get install ./$code_deb -y >> out 2>error
#did_succeed "Installing Code"
sudo apt-get install nodejs >> out 2>error
did_succeed "Installing NodeJs"
# Hide warning about Buffer() being deprecated
export NODE_OPTIONS="--no-deprecation"
code --install-extension pycom.pymakr@1.1.18 >> out 2>error
did_succeed "Installing PyMakr Extension"
wget -O pymakr.json ${pymakr_config_url} >> out 2>error
eval pymakr_file_name=${pymakr_config_path}/pymakr.json
cp pymakr.json ${pymakr_file_name} >> out 2>error
did_succeed "Copy PyMakr Config"

# If we get here, than everything successfully ran, so remove our tmp files.
rm deb_status error
