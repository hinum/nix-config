{
  perSystem = {pkgs, ...}: {
    packages.nixos-clean-generations = pkgs.writeShellScriptBin "nixos-clean-generations" ''

      set -euo pipefail
      : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"

      sudo nix-env -p /nix/var/nix/profiles/system/ --delete-generations old
      sudo nixos-rebuild boot --flake $NIXOS_FLAKE_PATH
      sudo nix-collect-garbage -d

    '';
  };
}
