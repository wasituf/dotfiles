#!/bin/bash

# Define Rofi arguments for vertical alignment
rofi_args=(-dmenu -p "Select an option:" -mesg "Use ↑ and ↓ to navigate, Enter to select.")

# Define your initial options
initial_options=("silicon" "tldr" "httpie")

# Function to show Rofi menu and handle user selection
show_menu() {
    selected_option=$(printf "%s\n" "${initial_options[@]}" | rofi "${rofi_args[@]}")

    # Handle the selected option
    case $selected_option in
        "silicon")
            silicon_menu
            ;;
        "tldr")
            tldr_menu
            ;;
        "httpie")
            httpie_menu
            ;;
        *)
            # Handle other cases or exit
            ;;
    esac
}

# Function for the 'silicon' submenu
silicon_menu() {
    silicon_sub_options=("silicon_option1" "silicon_option2" "silicon_option3")
    selected_sub_option=$(printf "%s\n" "${silicon_sub_options[@]}" | rofi "${rofi_args[@]}" -p "Select a silicon option:")
    
    # Handle the selected sub-option or go back to the main menu
    case $selected_sub_option in
        "silicon_option1")
            # Do something for silicon_option1
            ;;
        "silicon_option2")
            # Do something for silicon_option2
            ;;
        "silicon_option3")
            # Do something for silicon_option3
            ;;
        *)
            show_menu  # Go back to the main menu
            ;;
    esac
}

# Function for the 'tldr' submenu
tldr_menu() {
    # Define options for 'tldr' submenu
    # Similar structure as silicon_menu
    # ...
    show_menu
}

# Function for the 'httpie' submenu
httpie_menu() {
    # Define options for 'httpie' submenu
    # Similar structure as silicon_menu
    # ...
    show_menu
}

# Start the main menu
show_menu

