{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.starfish = pkgs.writeShellApplication {
      name = "starfish";
      runtimeInputs = with pkgs; [
        fish
        starship
        socat
        self'.packages.devfish
      ];
      text = ''
        fish -C "source ${pkgs.writeText "starfish_start" ''
          export STARSHIP_CONFIG=${./starship.toml}
          alias nix-shell='nix-shell --command "exec devfish"'
          function cd
            builtin cd $argv
            pwd | socat - UNIX-CONNECT:/tmp/pwd-deamon.sock
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
