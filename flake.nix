{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  inputs.nixos-lib.url = "github:nixos/nixpkgs?ref=nixos-unstable&dir=lib";

  inputs.alejandra.url = "github:kamadorueda/alejandra/3.0.0";

  outputs = {
    self,
    nixpkgs,
    nixos-lib,
    alejandra,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin" "i686-linux" "aarch64-linux"];
    callPackageFor = system: nixos-lib.lib.callPackageWith (nixpkgs.legacyPackages.${system} // {inherit (alejandra.packages.${system}) alejandra;});
  in {
    formatter = forAllSystems (system: alejandra.packages.${system}.default);
    lib = import ./lib inputs;

    devShell = forAllSystems (system: callPackageFor system ./dev-shell {});
  };
}
