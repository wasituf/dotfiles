#!/run/current-system/sw/bin/bash

# Define Rofi arguments for vertical alignment
rofi_args=(
	-no-config
	-no-lazy-grab
	-kb-move-end "Control+p"
	-kb-row-up "Up,Control+e"
	-dmenu
	-i
	-theme ./rofi/launcher.rasi
	-p ""
)

# Define your internal identifiers and their display labels
options=()

source ./config.sh

# Convert extension names to display names
for item in "${extensions[@]}"; do
	case "$item" in
	"calc")
		options+=("💱 Calc")
		;;
	"bitwarden")
		options+=("🔒 Bitwarden")
		;;
	"emoji")
		options+=("🤯 Emoji")
		;;
	"httpie")
		options+=("📡 Httpie")
		;;
	"silicon")
		options+=("🖨️ Silicon")
		;;
	"tldr")
		options+=("📖 Tldr")
		;;
	esac
done

# Import necessary extensions
for item in "${extensions[@]}"; do
	case "$item" in
	"calc")
		source ./scripts/calc.sh
		;;
	"bitwarden")
		source ./scripts/bitwarden.sh
		;;
	"emoji")
		source ./scripts/emoji.sh
		;;
	"httpie")
		source ./scripts/httpie.sh
		;;
	"silicon")
		source ./scripts/silicon.sh
		;;
	"tldr")
		source ./scripts/tldr.sh
		;;
	esac
done

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
	"💱 Calc")
		calc
		;;
	"🔒 Bitwarden")
		bitwarden
		;;
	"🤯 Emoji")
		emoji
		;;
	"🖨️ Silicon")
		silicon_submenu
		;;
	"📖 Tldr")
		tldr_submenu
		;;
	"📡 Httpie")
		httpie_submenu
		;;
	esac
}

# Start the main menu
show_menu
