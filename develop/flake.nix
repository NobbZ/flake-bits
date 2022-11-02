{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-bits.url = "github:nobbz/flake-bits";

  outputs = {self, flake-bits, nixpkgs, ...}@inputs: flake-bits.lib.mkFlake inputs {
    imports = [
      ./devshell.nix
      ./formatter.nix
    ];
  };
}
