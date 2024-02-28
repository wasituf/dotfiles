#!/usr/bin/env bash

FILE="$HOME/.config/scripts/relit/rofi/colors.rasi"

# Define Rofi arguments for vertical alignment
rofi_args=(
  -no-config 
  -no-lazy-grab 
  -kb-move-end "Control+p"
  -kb-row-up "Up,Control+e"
  -dmenu 
  -i
  -theme ~/.config/scripts/relit/rofi/launcher.rasi 
  -p ""
  -mesg "Use ↑ and ↓ to navigate, Enter to select."
)

# Define your internal identifiers and their display labels
options=("Silicon" "Tldr" "Httpie")

# Function to show Rofi menu and handle user selection
show_menu() {
    selected_option=$(printf "%s\n" "${options[@]}" | rofi "${rofi_args[@]}")

    # Handle the selected option
    for option in "${options[@]}"; do
        if [[ $selected_option == "$option" ]]; then
            handle_submenu "$option" "${rofi_args[@]}"
            break
        fi
    done

    echo "Selected Option: $selected_option"
}

# Function to handle the submenu for "silicon"
silicon_submenu() {
    silicon_sub_options=("From Clipboard" "From Clipboard: Highlight" "From File")
    selected_sub_option=$(printf "%s\n" "${silicon_sub_options[@]}" | rofi "${rofi_args[@]}" -p "Select a silicon option:")
    
    # Handle the selected sub-option or go back to the main menu
    case $selected_sub_option in
        "From Clipboard")
          silicon --from-clipboard -l rs --to-clipboard --background "#585b70" &
          ;;
        "From Clipboard: Highlight")
          # rofi -dmenu -theme ~/.config/scripts/relit/silicon/rofi/highlight.rasi
          ;;
        "From File")
          # rofi -dmenu -theme ~/.config/scripts/relit/silicon/rofi/from_file.rasi
          ;;
        *)
            show_menu  # Go back to the main menu
            ;;
    esac
}

# Function to handle the submenu for "tldr"
tldr_submenu() {
    # Define options for 'tldr' submenu
    # Similar structure as silicon_menu
    # ...
    show_menu
}

# Function to handle the submenu for "httpie"
httpie_submenu() {
    # Define options for 'httpie' submenu
    # Similar structure as silicon_menu
    # ...
    show_menu
}

# Function to handle the submenu based on the selected option
handle_submenu() {
    case $1 in
        "Silicon")
            silicon_submenu
            ;;
        "Tldr")
            tldr_submenu
            ;;
        "Httpie")
            httpie_submenu
            ;;
    esac
}

# Start the main menu
show_menu
