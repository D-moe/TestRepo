#!/bin/bash
# Define formatting.
check='\xE2\x9C\x94'
cross='\xE2\x9D\x8C'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

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

pip install -v rshell>>out 2>error
did_succeed "Installing rshell"
# Now add rshell to path
usr=$(whoami)
path="export PATH=/home/${usr}/.local/bin"
bashrc="/home/${usr}/.bashrc"
echo path>>${bashrc}
source ${bashrc}
did_succeed "Added rshell to path"
git clone https://github.com/D-moe/RobotCar.git>>out 2>error
did_succeed "Downloading code from github"



