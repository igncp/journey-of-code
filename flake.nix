{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = {
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells = {
          default = pkgs.mkShell {
            packages =
              []
              ++ (with pkgs; [
                bashInteractive
                haskellPackages.stack
                podman
                ruby
              ]);
          };
          swift = pkgs.mkShell.override {inherit (pkgs.swift) stdenv;} {
            packages =
              []
              ++ (with pkgs; [
                swift-format
                swiftPackages.Foundation
                swiftPackages.swift
                swiftPackages.swiftpm
              ]);
          };
        };
      }
    );
}
