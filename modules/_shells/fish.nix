{pkgs, ...}: pkgs.writeShellScriptBin "starfish" ''

  export STARSHIP_CONFIG=${./starship.toml}
  ${pkgs.fish}/bin/fish -C "${pkgs.starship}/bin/starship init fish | source"

''
