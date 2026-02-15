{pkgs, ...}: pkgs.writeShellScriptBin "starfish" ''

  ${pkgs.fish}/bin/fish -C "source ${pkgs.writeShellScript "starfish_start" ''

    export STARSHIP_CONFIG=${./starship.toml}
    alias nix-shell='nix-shell --command "exec ${import ./devfish.nix { inherit pkgs; }}/bin/devfish"'
    ${pkgs.starship}/bin/starship init fish | source

  ''}"

'' // {
  shellPath = "/bin/starfish";
}
