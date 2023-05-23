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
usr=$(whoami)
cp -r /home/$usr/RobotCar /home/$usr/Week4RobotCar
rm -rf /home/$usr/RobotCar>out 2>error
did_succeed "Removed Prior RobotCar repo"
git clone https://github.com/D-moe/RobotCar.git>>out 2>&1
did_succeed "Downloading Week 5 Code from Github"
echo "To run commands on your car first type\ncd RobotCar!"

echo "You will need to close and reopen your terminal for changes to take effect"
rm error
