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
            shellHook = ''
              eval "$(luarocks path)"
            '';
            packages =
              []
              ++ (with pkgs; [
                bashInteractive
                podman

                go
                gopls

                haskellPackages.stack

                cargo
                rust-analyzer
                rustc

                gradle
                kotlin
                kotlin-language-server
                ktlint

                lua
                luarocks

                libyaml
                ruby
                ruby-lsp
                zlib

                php
                php.packages.composer
                php82Packages.php-cs-fixer
                phpactor
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
