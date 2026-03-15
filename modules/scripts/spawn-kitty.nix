{
  perSystem = {pkgs, ...}: {
    packages.spawn-kitty = pkgs.writeShellApplication {
      name = "spawn-kitty";
      runtimeInputs = [pkgs.socat pkgs.kitty];
      text = ''
        set -euo pipefail
        if pgrep kitty-wrapped; then
          kitty -d "$(echo | socat - UNIX-CONNECT:/tmp/pwd-deamon.sock || echo "$HOME")"
        else
          echo "$HOME" | socat - UNIX-CONNECT:/tmp/pwd-deamon.sock || :
          kitty -d "$HOME"
        fi
      '';
    };
  };
}
