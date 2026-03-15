{
  perSystem = {pkgs, ...}: {
    packages.spawn-kitty = pkgs.writeTextFile {
      name = "spawn-kitty";
      text = ''
        #!${pkgs.fish}/bin/fish

        if not pgrep kitty-wrapped
          set -U KITTY_CWD "$HOME"
        end
        exec kitty -d "$KITTY_CWD"
      '';
      executable = true;
      destination = "/bin/spawn-kitty";
    };
  };
}
