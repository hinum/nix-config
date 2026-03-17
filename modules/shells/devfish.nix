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
          set -U fish_greeting ""
          starship init fish | source
        ''}"
      '';

      derivationArgs = {
        shellPath = "/bin/devfish";
      };
    };
  };
}
