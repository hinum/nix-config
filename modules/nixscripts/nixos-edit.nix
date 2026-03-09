{
  perSystem = {pkgs, ...}: let
    alejandra = "${pkgs.alejandra}/bin/alejandra";
  in {
    packages.nixos-edit = pkgs.writeShellScriptBin "nixos-edit" ''

      set -euo pipefail
      : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"
      ACTION=${"$"}{1:-"switch"}

      $EDITOR $NIXOS_FLAKE_PATH
      cd $NIXOS_FLAKE_PATH

      # Early return if no changes were detected
      if git diff HEAD --quiet; then
        echo "No changes detected, exiting."
        exit 0
      fi

      # Autoformat your nix files
      ${alejandra} . &>/dev/null \
        || ( ${alejandra} . ; echo "formatting failed!" && exit 1)

      git diff --color=always -U0 '*.nix' | less -R
      git add .

      if [[ $ACTION == "test" ]]; then
        sudo nixos-rebuild test --flake $NIXOS_FLAKE_PATH
        exit 0
      elif [[ $ACTION == "boot" ]]; then
        sudo nixos-rebuild boot --flake $NIXOS_FLAKE_PATH
      elif [[ $ACTION == "switch" ]]; then
        sudo nixos-rebuild switch --flake $NIXOS_FLAKE_PATH
      else
        echo "unrecognizable option: only accpet switch, boot, test"
        exit 1
      fi
      echo ""
      current=$(nixos-rebuild list-generations | awk "\$8==\"True\" {print \"generation \" \$1}")
      git commit -m "$current"
      git push
    '';
  };
}
