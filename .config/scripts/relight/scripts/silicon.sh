#!/run/current-system/sw/bin/bash

silicon_submenu() {
	highlight() {
		hl_prompt() {
			rofi -dmenu -no-config -i -no-fixed-num-lines -mesg "Format: 1 | 1-4" -p "" -theme ./rofi/prompt.rasi &
		}
		hl=$(hl_prompt &)

		lang_prompt() {
			rofi -dmenu -no-config -i -no-fixed-num-lines -mesg "File extension to use. e.g. typescript, rs" -p "" -theme ./rofi/prompt.rasi &
		}
		lang=$(lang_prompt &)

		silicon --from-clipboard -l "${lang}" --highlight-lines "${hl}" &
	}

	from_file() {
		prompt() {
			rofi -dmenu -no-config -i -no-fixed-num-lines -mesg "Type file location" -p "" -theme ./rofi/prompt.rasi &
		}

		ans=$(prompt &)

		IFS='.'
		read -ra ansarr <<<"$ans"

		silicon "${ans}" -l "${ansarr[-1]}"
	}

	silicon_sub_options=("📋 From Clipboard" "🖍️ From Clipboard: Highlight" "📁 From File")
	selected_sub_option=$(printf "%s\n" "${silicon_sub_options[@]}" | rofi "${rofi_args[@]}" -p "Select a silicon option:")

	# Handle the selected sub-option or go back to the main menu
	case $selected_sub_option in
	"📋 From Clipboard")
		lang_prompt() {
			rofi -dmenu -no-config -i -no-fixed-num-lines -mesg "File extension to use. e.g. typescript, rs" -p "" -theme ./rofi/prompt.rasi &
		}
		lang=$(lang_prompt &)

		silicon --from-clipboard -l "${lang}" &
		;;
	"🖍️ From Clipboard: Highlight")
		highlight
		;;
	"📁 From File")
		from_file
		;;
	*)
		show_menu # Go back to the main menu
		;;
	esac
}
