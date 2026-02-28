{
  # only change if you know what youre doing (apparently)
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://cache.nixos-cuda.org"];
    trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="];
  };

  nix.gc = {
    automatic = true;
    dates = "1 day";
  };
}
