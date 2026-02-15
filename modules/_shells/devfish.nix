{pkgs, ...}: pkgs.writeShellScriptBin "devfish" ''

  export STARSHIP_CONFIG=${./starship-dev.toml}
  ${pkgs.fish}/bin/fish -C "${pkgs.starship}/bin/starship init fish | source"

''
