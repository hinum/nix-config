{
  perSystem = {pkgs, ...}: {
    packages.devfish = pkgs.writeShellApplication {
      name = "devfish";
      runtimeInputs = with pkgs; [
        fish
        starship
      ];

      text = ''
        fish -C "source ${pkgs.writeText "start_devfish" ''
          export STARSHIP_CONFIG=${./starship-dev.toml}
          set -ge fish_greeting
          function cd
            builtin cd $argv
            set -U KITTY_CWD $(pwd)
          end
          starship init fish | source
        ''}"
      '';

      derivationArgs = {
        shellPath = "/bin/devfish";
      };
    };
  };
}
