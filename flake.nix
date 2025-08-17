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
                go
                gradle
                haskellPackages.stack
                kotlin
                ktfmt
                lua
                podman
                ruby
              ]);
          };
          swift = pkgs.mkShell.override {inherit (pkgs.swift) stdenv;} {
            packages =
              []
              ++ (with pkgs; [
                sourcekit-lsp
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
