{
  perSystem = {pkgs, ...}: let
    alejandra = "${pkgs.alejandra}/bin/alejandra";
  in {
    packages.nixos-edit = pkgs.writeShellScriptBin "nixos-edit" ''

      set -euo pipefail
      : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"

      $EDITOR $NIXOS_FLAKE_PATH
      pushd $NIXOS_FLAKE_PATH > /dev/null

      # Early return if no changes were detected
      if git diff --quiet; then
          echo "No changes detected, exiting."
          popd > /dev/null
          exit 0
      fi

      # Autoformat your nix files
      ${alejandra} . &>/dev/null \
        || ( ${alejandra} . ; echo "formatting failed!" && exit 1)

      git diff --color=always -U0 '*.nix' | less -R
      git add .
      if ! sudo nixos-rebuild switch --flake $NIXOS_FLAKE_PATH; then
        popd > /dev/null
        exit 1
      fi

      current=$(nixos-rebuild list-generations | awk "\$8==\"True\" {print \"generation \" \$1}")
      git commit -m "$current"
      git push
      popd > /dev/null
    '';
  };
}
