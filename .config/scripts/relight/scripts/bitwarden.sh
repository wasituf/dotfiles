#!/run/current-system/sw/bin/bash

bitwarden() {
	params=(
		--no-help
		--keybindings Ctrl+Return:copy:password
	)
	rofi-rbw ${params[@]} -r "" --selector-args="-kb-accept-custom '' -theme ./rofi/launcher.rasi"
}
