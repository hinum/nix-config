{
  perSystem = {pkgs, ...}: {
    packages.starfish = pkgs.writeShellApplication {
      name = "starfish";
      runtimeInputs = with pkgs; [
        fish
        starship
        fortune
        cowsay
        jq
      ];
      text = ''
        fish -C "source ${pkgs.writeText "starfish_start" ''
          export STARSHIP_CONFIG=${./starship.toml}
          alias nix-shell='nix-shell --command "exec devfish"'
          function fish_greeting
            if [ (kitten @ --to unix:/tmp/spawn-kitty ls | jq length) -le 2 ]
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
