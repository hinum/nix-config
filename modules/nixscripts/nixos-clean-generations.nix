{

  perSystem = {pkgs, ...}: {
    packages.nixos-clean-generations = pkgs.writeShellScriptBin "nixos-clean-generations" ''

set -euo pipefail
: "${"$"}{NIXOS_FLAKE_PATH:? cant find enviroment variable}"

sudo nix-env -p /nix/var/nix/profiles/system/ --delete-generations old
sudo nix-collect-garbage -d
sudo nixos-rebuild boot --flake $NIXOS_FLAKE_PATH

    '';
  };
}
