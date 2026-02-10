# This file is responsible for setting dev environment
# It defines binaries that will be provided and logic that will be run
# when 'nix develop .' will be executed
{ pkgs }:
let
  displayToolsVersions = ''
    printf '%.0s-' {1..80}; printf '\n'

    # CMake version
    if command -v cmake >/dev/null 2>&1; then
        CMAKE_VER=$(cmake --version | head -n1 | grep -oP '(?<=version )\d+\.\d+\.\d+')
        echo "CMake: $CMAKE_VER"
    fi

    # cmake-lint version
    if command -v cmake-lint >/dev/null 2>&1; then
        CMAKE_LINT_VER=$(cmake-lint -v)
        echo "cmake-lint: $CMAKE_LINT_VER"
    fi

    # cmake-format version
    if command -v cmake-format >/dev/null 2>&1; then
        CMAKE_FORMAT_VER=$(cmake-format -v)
        echo "cmake-format: $CMAKE_FORMAT_VER"
    fi

    # Doxygen version
    if command -v doxygen >/dev/null 2>&1; then
        DOXYGEN_VER=$(doxygen -v)
        echo "Doxygen: $DOXYGEN_VER"
    fi

    # Meson version
    if command -v meson >/dev/null 2>&1; then
        MESON_VER=$(meson -v)
        echo "Meson: $MESON_VER"
    fi


    printf '%.0s-' {1..80}; printf '\n'
  '';

  displayGreetings = ''
    echo "C environment"
  '';
in
{
  default = pkgs.mkShell {
    # Nix packages provided in environment
    buildInputs = with pkgs; [
        # CMake build system 
        cmake
        # CMake TUI
        cmakeCurses
        # CMake GUI
        #cmakeWithGui
        # CMake linter
        cmake-lint
        # CMake format
        cmake-format

        # Doxygen documentation generator
        doxygen

        # Meson build system
        meson
    ];

    # Logic run on environment activation
    shellHook = ''
      ${displayGreetings}
      ${displayToolsVersions}
    '';
  };
}
