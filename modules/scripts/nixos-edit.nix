{
  perSystem = {pkgs, ...}: {
    packages.nixos-edit = pkgs.writeShellApplication {
      name = "nixos-edit";
      runtimeInputs = [
        pkgs.alejandra
        pkgs.git
      ];
      text = ''

        set -euo pipefail
        : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"
        ACTION=${"$"}{1:-"switch"}

        $EDITOR "$NIXOS_FLAKE_PATH"
        cd "$NIXOS_FLAKE_PATH"

        # Early return if no changes were detected
        if git diff HEAD --quiet; then
          echo "No changes detected, exiting."
          exit 0
        fi

        # Autoformat your nix files
        alejandra . &>/dev/null \
          || ( alejandra . ; echo "formatting failed!" && exit 1)


        if [[ $ACTION == "test" ]]; then
          git diff --color=always | less -R
          git add .
          sudo nixos-rebuild test --flake "$NIXOS_FLAKE_PATH"
          exit 0
        elif [[ $ACTION == "boot" ]]; then
          git diff --color=always HEAD | less -R
          git add .
          sudo nixos-rebuild boot --flake "$NIXOS_FLAKE_PATH"
        elif [[ $ACTION == "switch" ]]; then
          git diff --color=always HEAD | less -R
          git add .
          sudo nixos-rebuild switch --flake "$NIXOS_FLAKE_PATH"
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
  };
}
