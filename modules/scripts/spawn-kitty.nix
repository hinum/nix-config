{
  perSystem = {pkgs, ...}: {
    packages.spawn-kitty = pkgs.writeShellApplication {
      name = "spawn-kitty";

      runtimeInputs = [
        pkgs.kitty
      ];
      text = ''
        kitten @ --to unix:/tmp/spawn-kitty \
          launch -m 'state:focused_os_window and recent:0' --cwd current --type os-window \
        || kitten @ --to unix:/tmp/spawn-kitty launch
      '';
    };
  };
}
