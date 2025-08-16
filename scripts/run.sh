#!/usr/bin/env bash

set -euo pipefail

# Script to run the examples.
# Options to support in future:
# - run only tests, run tests and solutions, compile only, filtering
# - check the code (linting, formatting, etc.)
# - install dependencies

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
FILTER="${FILTER:-}"
INSTALL="${INSTALL:-0}"
COMPILE="${COMPILE:-0}"
CHECK="${CHECK:-0}"
TEST="${TEST:-0}"

common_scripts() {
  if [ "$INSTALL" == "1" ] && [ -f install.sh ]; then
    echo "Installing: $PWD"
    bash install.sh || {
      echo "Error installing in $PWD"
      exit 1
    }
  fi

  if [ "$COMPILE" == "1" ] && [ -f compile.sh ]; then
    echo "Compiling: $PWD"
    bash compile.sh || {
      echo "Error compiling in $PWD"
      exit 1
    }
  fi

  if [ "$CHECK" == "1" ] && [ -f check.sh ]; then
    echo "Checking: $PWD"
    bash check.sh || {
      echo "Error checking in $PWD"
      exit 1
    }
  fi

  if [ "$TEST" == "1" ] && [ -f test.sh ]; then
    echo "Testing: $PWD"
    bash test.sh || {
      echo "Error running tests in $PWD"
      exit 1
    }
  fi
}

resolve_swift() {
  local SOLUTIONS=$(find . -maxdepth 1 -type f -name '0[12].swift' | sort)

  if [ "$COMPILE" == "1" ] && [ ! -f compile.sh ]; then
    EXTRA_SWIFT_FILES=$(find . -maxdepth 1 -type f -name '*.swift' ! -name '0[12].swift' ! -name 'spec.swift' | sort | tr '\n' ' ')

    for solution in $SOLUTIONS; do
      nix develop \
        --extra-experimental-features nix-command \
        --extra-experimental-features flakes \
        ../../..#swift \
        --command bash -c \
        "swiftc $solution $EXTRA_SWIFT_FILES -o $solution.c" || {
        echo "Error compiling solution: $PWD/$solution"
        exit 1
      }
    done

    if [ -f "spec.swift" ]; then
      nix develop \
        --extra-experimental-features nix-command \
        --extra-experimental-features flakes \
        ../../..#swift \
        --command bash -c \
        "swiftc spec.swift $EXTRA_SWIFT_FILES -o spec.swift.c" || {
        echo "Error compiling spec: $PWD/$solution"
        exit 1
      }
    fi
  fi

  if [ "$CHECK" == "1" ] && [ ! -f check.sh ]; then
    nix develop \
      --extra-experimental-features nix-command \
      --extra-experimental-features flakes \
      ../../..#swift \
      --command bash -c \
      "swift-format -i ./*.swift && swift-format lint ./*.swift" || {
      echo "Error checking solution: $PWD/$solution"
      exit 1
    }
  fi

  if [ "$TEST" == "1" ] && [ ! -f test.sh ] && [ -f spec.swift.c ]; then
    ./spec.swift.c || {
      echo "Error running spec: $PWD/spec.swift.c"
      exit 1
    }
  fi

  for solution in $SOLUTIONS; do
    local SOLUTION_PATH=$(readlink -f "$solution")
    "./$solution.c" || {
      echo "Error running solution: $PWD/$solution.c"
      exit 1
    }
    echo "$SOLUTION_PATH" ✓
  done
}

resolve_ruby() {
  common_scripts

  if [ "$INSTALL" == "1" ] && [ ! -f install.sh ] && [ -f Gemfile ]; then
    echo "Installing Ruby dependencies: $PWD"
    bundle install
  fi

  if [ "$CHECK" == "1" ] && [ ! -f check.sh ] && [ -f .rubocop.yml ]; then
    EXTRA_DIRS=$([[ -d src ]] && echo " src/**/*.rb" || echo "")
    bundle exec rubocop -x ./*.rb $EXTRA_DIRS || {
      echo "Error running RuboCop in $PWD"
      exit 1
    }
  fi

  if [ "$TEST" == "1" ] && [ ! -f test.sh ] && [ -f Gemfile ] && [ -n "$(grep rspec Gemfile)" ]; then
    echo "Running tests: $PWD"
    TEST_FILES=$([[ -d src ]] && echo "src" || echo "./*_spec.rb")
    bundle exec rspec $TEST_FILES || {
      echo "Error running tests in $PWD"
      exit 1
    }
  fi

  local SOLUTIONS=$(find . -maxdepth 1 -type f -name '0[12].rb' | sort)
  for solution in $SOLUTIONS; do
    local SOLUTION_PATH=$(readlink -f "$solution")
    ruby "$solution" || {
      echo "Error running solution: $PWD/$solution"
      exit 1
    }
    echo "$SOLUTION_PATH" ✓
  done
}

resolve_haskell() {
  common_scripts

  if [ "$INSTALL" == "1" ] && [ ! -f install.sh ] && [ -f package.yaml ]; then
    stack --nix install || {
      echo "Error installing Haskell dependencies in $PWD"
      exit 1
    }
  fi

  local SOLUTIONS=$(find app -maxdepth 1 -type f -name '0[12].hs' | sort)

  if [ "$COMPILE" == "1" ] && [ ! -f install.sh ] && [ -f package.yaml ]; then
    stack --nix build || {
      echo "Error building: $PWD"
      exit 1
    }
  fi

  if [ "$TEST" == "1" ] && [ ! -f test.sh ] && [ -d tests ] && [ -f package.yaml ]; then
    echo "Running tests: $PWD"
    stack --nix test || {
      echo "Error running tests in $PWD"
      exit 1
    }
  fi

  for solution in $SOLUTIONS; do
    SOLUTION_NAME=$(echo "$solution" | sed 's|app/||; s|\.hs$||')
    local SOLUTION_PATH=$(readlink -f "$solution")
    stack --nix exec "$SOLUTION_NAME" || {
      echo "Error running solution: $PWD/$solution"
      exit 1
    }
    echo "$SOLUTION_PATH" ✓
  done
}

main() {
  local YEARS=$(find . -maxdepth 1 -type d -name '[0-9][0-9][0-9][0-9]' | sort)

  for year in $YEARS; do
    cd "$SCRIPT_DIR"/../"$year"
    EXERCISES=$(find . -maxdepth 1 -type d -name '[0-9]*' | sort)
    YEAR_DIR=$(pwd)

    for exercise in $EXERCISES; do
      cd "$YEAR_DIR"/"$exercise"
      EXERCISE_DIR=$(pwd)

      RESOLUTIONS=$(find . -mindepth 1 -maxdepth 1 -type d | sort)

      for resolution in $RESOLUTIONS; do
        cd "$EXERCISE_DIR"/"$resolution"

        if [ -n "$FILTER" ] && [[ ! "$PWD" =~ $FILTER ]]; then
          continue
        fi

        case "$resolution" in
        *ruby)
          resolve_ruby
          ;;
        *swift)
          resolve_swift
          ;;
        *haskell)
          resolve_haskell
          ;;
        *)
          echo "Unknown resolution type for $year/$exercise/$resolution"
          exit 1
          ;;
        esac
      done
    done
  done
}

main
