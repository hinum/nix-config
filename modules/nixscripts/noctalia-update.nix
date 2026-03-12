{
  perSystem = {pkgs, ...}: let
    jq = "${pkgs.jq}/bin/jq";
  in {
    packages.noctalia-update = pkgs.writeShellScriptBin "noctalia-update" ''
      set -euo pipefail
      : "${"$"}{NIXOS_FLAKE_PATH:? cant find the NIXOS_FLAKE_PATH variable}"
      cd $NIXOS_FLAKE_PATH

      noctalia-shell ipc call state all | ${jq} .settings > home/configs/noctalia.json
      git diff -U0 --color=always ./home/configs/noctalia.json | less
      echo "note: this does not stage the file so maybe run nixos-edit switch after"
    '';
  };
}
