#!/run/current-system/sw/bin/bash

calc() {
	options=(
		-modes calc
		-show calc
		-no-show-match
		-no-sort
		-terse
		-no-persist-history
		-no-history
		-hint-welcome "->"
		-theme ./rofi/calc.rasi
	)
	rofi ${options[@]} -hint-result "-> " -display-calc ""
}
