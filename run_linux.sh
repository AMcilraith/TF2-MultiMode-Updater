#!/bin/bash

# Change to the directory where the script resides
cd "$(dirname "$0")" || { echo "Failed to change directory"; exit 1; }

# Set Directories
steam_dir="$HOME/.steam/steam"
tf2_path="$steam_dir/steamapps/common/Team Fortress 2/tf"

# Start Options Menu
startOptions() {
    clear
    echo
    echo "Select what you'd like to do to play TF2."
    echo
    echo "1. Start Normally"
    echo "2. Update Configs Only"
    echo "3. Delete Mod Cache Only"
    echo "4. Set Casual Configuration Only"
    echo "5. Set Competitive Configuration Only"
    echo "6. Remove Mods Only, Keep Existing Configuration"
    echo "7. Start in Casual Configuration"
    echo "8. Start in Competitive Configuration"
    echo "9. Remove Mods and Start in Current Configuration"
    echo "10. Start in Current Configuration"
    echo "11. Switch HUD"
    echo
    getOptions
}

# Get User Options
getOptions() {
    read -p "Type your choice without spacing (e.g. 1,2,3): " choices
    if [ -z "$choices" ]; then
        echo "Please enter a valid option"
        getOptions
    else
        for choice in $(echo "$choices" | tr "," "\n"); do
            case $choice in
                1) option1 ;;
                2) option2 ;;
                3) option3 ;;
                4) option4 ;;
                5) option5 ;;
                6) option6 ;;
                7) option7 ;;
                8) option8 ;;
                9) option9 ;;
                10) option10 ;;
                11) option11 ;;
                *) echo "Invalid option: $choice" ;;
            esac
        done
    fi
    echo
    echo "Done!"
}

# Option 1 - Start Normally
option1() {
    "$steam_dir/steam.sh" steam://rungameid/440
}

# Option 2 - Update Configs Only
option2() {
    clear
    cp -r cfg/* "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/overrides/"
    startOptions
}

# Option 3 - Delete Mod Cache Only
option3() {
    clear
    find "$tf2_path/custom" -name "*.vpk.sound.cache" -delete
    startOptions
}

# Option 4 - Set Casual Configuration Only
option4() {
    clear
    # Remove existing custom files
    rm -rf "$tf2_path/custom"/*
    cp -r custom_casual/* "$tf2_path/custom/"
    cp autoexec_casual/autoexec.cfg "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/overrides/"
    startOptions
}

# Option 5 - Set Competitive Configuration Only
option5() {
    clear
    rm -rf "$tf2_path/custom"/*
    cp -r custom_comp/* "$tf2_path/custom/"
    cp autoexec_comp/autoexec.cfg "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/overrides/"
    startOptions
}

# Option 6 - Remove Mods Only
option6() {
    clear
    rm -rf "$tf2_path/custom"/*
    startOptions
}

# Option 7 - Start in Casual Configuration
option7() {
    clear
    rm -rf "$tf2_path/custom"/*
    cp -r custom_casual/* "$tf2_path/custom/"
    cp autoexec_casual/autoexec.cfg "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/overrides/"
    "$steam_dir/steam.sh" steam://rungameid/440
}

# Option 8 - Start in Competitive Configuration
option8() {
    clear
    rm -rf "$tf2_path/custom"/*
    cp -r custom_comp/* "$tf2_path/custom/"
    cp autoexec_comp/autoexec.cfg "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/"
    cp -r cfg/* "$tf2_path/cfg/overrides/"
    "$steam_dir/steam.sh" steam://rungameid/440
}

# Option 9 - Remove Mods and Play Without
option9() {
    clear
    rm -rf "$tf2_path/custom"/*
    "$steam_dir/steam.sh" steam://rungameid/440
}

# Option 10 - Start in Current Configuration
option10() {
    clear
    find "$tf2_path/custom" -name "*.vpk.sound.cache" -delete
    "$steam_dir/steam.sh" steam://rungameid/440
}

# Option 11 - Switch HUD
option11() {
    clear
    echo "Available HUDs:"
    ls -1 custom_hud
    read -p "Type the name of the HUD you want to use: " hud_choice
    rm -rf "$tf2_path/custom/hud"
    cp -r "custom_hud/$hud_choice/*" "$tf2_path/custom/hud"
    startOptions
}

# Call the start options menu when the script runs
startOptions

exit
