{
  perSystem = {pkgs, ...}: {
    packages.starfish = pkgs.writeShellApplication {
      name = "starfish";
      runtimeInputs = with pkgs; [
        fish
        starship
        fortune
        cowsay
      ];
      text = ''
        fish -C "source ${pkgs.writeText "starfish_start" ''
          export STARSHIP_CONFIG=${./starship.toml}
          alias nix-shell='nix-shell --command "exec devfish"'
          function cd
            builtin cd $argv
            set -U KITTY_CWD $(pwd)
          end
          function fish_greeting
            if [ (pgrep kitty-wrapped | wc -l) -le 1 ]
              fortune | cowsay -f tux
            end
          end
          starship init fish | source
        ''}"
      '';

      derivationArgs = {
        shellPath = "/bin/starfish";
      };
    };
  };
}
