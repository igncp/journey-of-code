#!/usr/bin/env bash

podman run --rm -it \
  -v joc_nix:/nix \
  -v joc_root:/root \
  -v $PWD:/app \
  -w /app \
  nixos/nix:2.30.2 \
  nix develop \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes
