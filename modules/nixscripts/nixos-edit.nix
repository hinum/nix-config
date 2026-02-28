{
  perSystem = {pkgs,...}: let
    alejandra = "${pkgs.alejandra}/bin/alejandra";
  in {

    packages.nixos-edit = pkgs.writeShellScriptBin "nixos-edit" ''

set -euo pipefail
: "${"$"}{NIXOS_FLAKE_PATH:? cant find enviroment variable}"

$EDITOR $NIXOS_FLAKE_PATH
pushd $NIXOS_FLAKE_PATH

# Early return if no changes were detected
if git diff --quiet; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# Autoformat your nix files
${alejandra} . &>/dev/null \
  || ( ${alejandra} . ; echo "formatting failed!" && exit 1)

git diff -U0 '*.nix'

echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake $NIXOS_FLAKE_PATH &>tmp/nixos-switch.log || (cat tmp/nixos-switch.log | grep --color error && exit 1)

current=$(nixos-rebuild list-generations | grep current)
git commit -am "$current"

popd
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

    '';
  };
}
