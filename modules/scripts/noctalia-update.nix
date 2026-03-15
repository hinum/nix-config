{
  perSystem = {pkgs, ...}: {
    packages.noctalia-update = pkgs.writeShellApplication {
      name = "noctalia-update";
      runtimeInputs = [pkgs.jq pkgs.git];
      text = ''
        set -euo pipefail
        : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"
        cd "$NIXOS_FLAKE_PATH"

        noctalia-shell ipc call state all | jq .settings > home/configs/noctalia.json
        git diff -U0 --color=always ./home/configs/noctalia.json | less
        echo "note: this does not stage the file so maybe run nixos-edit switch after"
      '';
    };
  };
}
