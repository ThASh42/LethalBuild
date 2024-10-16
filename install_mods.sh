#!/bin/bash

# Function to find Steam game folder
find_steam_game_folder() {
    echo "Searching for Lethal Company game directory..."

    # Check different common paths for the game folder (adjust as needed)
    if [ -d "$HOME\.steam\steam\steamapps\common\Lethal Company" ]; then
        GAME_DIR="$HOME\.steam\steam\steamapps\common\Lethal Company"
    elif [ -d "$HOME\.local\share\Steam\steamapps\common\Lethal Company" ]; then
        GAME_DIR="$HOME\.local\share\Steam\steamapps\common\Lethal Company"
    elif [ -d "\mnt\c\Program Files (x86)\Steam\steamapps\common\Lethal Company" ]; then
        GAME_DIR="\mnt\c\Program Files (x86)\Steam\steamapps\common\Lethal Company"
    elif [ -d "\mnt\d\SteamLibrary\steamapps\common\Lethal Company" ]; then
        GAME_DIR="\mnt\d\SteamLibrary\steamapps\common\Lethal Company"
    elif [ -d "D:\SteamLibrary\steamapps\common\Lethal Company" ]; then
        GAME_DIR="D:\SteamLibrary\steamapps\common\Lethal Company"
    elif [ -d "C:\Program Files (x86)\Steam\steamapps\common\Lethal Company" ]; then
        GAME_DIR="C:\Program Files (x86)\Steam\steamapps\common\Lethal Company"
    else
        echo "Could not find the Lethal Company directory. Please enter the path manually:"
        read -r GAME_DIR
    fi

    # Check if the game folder exists C:\Program Files (x86)\Steam\steamapps\common\Lethal Company
    if [ -d "$GAME_DIR" ]; then
        echo "Lethal Company found at: $GAME_DIR"
    else
        echo "Error: Lethal Company directory not found."
        exit 1
    fi
}

# Function to copy BepInEx folder to game directory
install_mods() {
    echo "Copying BepInEx to game directory..."

    if [ -d "BepInEx" ]; then
        cp -r BepInEx "$GAME_DIR"
        echo "Mods installed successfully."
    else
        echo "Error: BepInEx folder not found in the repository."
        exit 1
    fi
}

# Main script execution
find_steam_game_folder
install_mods

echo "Installation complete."

# Navigate to the parent directory
cd ..
# Remove the LethalBuild-master directory
echo "Removing the LethalBuild-master directory..."
rm -rf LethalBuild-master

echo "Cleanup complete."

sleep 3s
