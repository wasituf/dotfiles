#!/run/current-system/sw/bin/bash

if cmp -s ~/.config/polybar/scripts/latest_commit_temp.txt ~/.config/polybar/scripts/latest_commit.txt; then
  echo "System is already up to date!"
  echo "Press Enter to exit now..."
  echo "This window will terminate in..."
  for ((time_left = 5; time_left > 0; time_left--)); do
    echo "======== $time_left seconds ========)"
    read -t 1
    [ $? -eq 0 ] && break
  done
  exit
else

echo "This will update all packages and rebuild NixOS..."
read -p "Confirm to proceed. (y/n): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  sudo -v  # Prompt for sudo password upfront

  # Check if sudo is already authenticated or exit if timeout
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &

  read -p "Updating Nix channels and rebuilding NixOS. Press [Enter] to continue..."

  # Update all channels
  cd $HOME/.config/home-manager
  nix flake update
  cd $HOME/.config/polybar/scripts
  echo "->> Updated flakes <<-"

  # Update home-manager 
  nix-collect-garbage -d && home-manager switch
  echo "->> Upgraded to latest Home-Manager version <<-"

  # Update NixOS
  sudo nix-collect-garbage -d && sudo nixos-rebuild switch 
  echo "->> Updated all pkgs & switched to latest NixOS version <<-"

  # Copy configuration files to git directory
  sudo cp /etc/nixos/configuration.nix $HOME/symlinks/etc/nixos/
  sudo cp /etc/nixos/flake.nix $HOME/symlinks/etc/nixos/
  echo "->> Copied configuration to git directory <<-"

  # Check if the temporary file exists
  if [ -f "$HOME/.config/polybar/scripts/latest_commit_temp.txt" ]; then
    # Move the temporary file to replace latest_commit.txt
    sudo cp $HOME/.config/polybar/scripts/latest_commit_temp.txt $HOME/.config/polybar/scripts/latest_commit.txt
    echo "->> Current commit hash has been updated. <<-"
  else
    echo "Error: latest_commit_temp.txt not found. Run the notify-script first."
  fi


  echo "Reboot now to finalize the update..."
  read -p "Reboot now? (y/n): " reboot_confirm

  if [[ "$reboot_confirm" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    sudo reboot
  else
    echo "Update completed. You may need to manually reboot later to finalize the update."
  fi
else
  echo "Update canceled."
fi

fi
