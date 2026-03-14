{
  perSystem = {pkgs, self', ...}: {
    packages.bundle-nixvim = pkgs.writeShellApplication {
      name = "bundle-nixvim";
      runtimeInputs = [
        pkgs.zip
        self'.packages.nixvim
      ];

      text = ''
        set -euo pipefail
        CWD=$(pwd)
        PACKPATH=$(cat "$(which nvim)" | grep -oP 'packpath\^=\K([a-zA-Z0-9/.-]+)')
        INITPATH=$(cat "$(which nvim)" | grep -oP '\-u \K([a-zA-Z0-9/-]+)\.lua')

        cd "$(mktemp -d)"

        cp -r "$PACKPATH/pack" ./pack
        cp "$INITPATH" ./init.lua

        # patch nix/store and run/current-system/sw paths
        sed -i -E 's/\/nix\/store\/[a-zA-Z0-9.-]+((\/\w+)+)/\1/g' ./init.lua
        sed -i -E 's/\/run\/current-system\/sw((\/\w+)+)/\1/g' ./init.lua

        cat <<'EOF' > ./nvim
        #!/usr/bin/env bash
        SCRIPT_DIR=$( cd -- "$( dirname -- "${"$"}{BASH_SOURCE[0]}" )" &> /dev/null && pwd )
        nvim --cmd "set packpath^=$SCRIPT_DIR" -u $SCRIPT_DIR/init.lua "$@"
        EOF

        chmod +x ./nvim
        zip --recurse-paths "$CWD/nvim.zip" .
        rm -rf "$(pwd)"
      '';
    };
  };
}
