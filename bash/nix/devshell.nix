# This file is responsible for setting dev environment
# It defines binaries that will be provided and logic that will be run
# when 'nix develop .' will be executed
{ pkgs }:
let
  displayToolsVersions = ''
    printf '%.0s-' {1..80}; printf '\n'

    # Get and display Bash version
    BASH_VER=$(bash --version | head -n1 | grep -oP '(?<=version )\d+\.\d+\.\d+')
    echo "Bash: $BASH_VER"

    # Get and display ShellCheck version
    SHELLCHECK_VER=$(shellcheck --version | grep -oP '(?<=version: )\d+\.\d+\.\d+')
    echo "ShellCheck: $SHELLCHECK_VER"

    # Get and disply shfmt version
    SHFMT_VER=$(shfmt -version)
    echo "Shfmt: $SHFMT_VER"

    printf '%.0s-' {1..80}; printf '\n'
  '';

  displayGreetings = ''
    echo "Bash environment"
  '';
in
{
  default = pkgs.mkShell {
    # Nix packages provided in environment
    buildInputs = with pkgs; [
      bash # Bash shell
      shellcheck # Shell Linter
      shfmt # Shell formatter
    ];

    # Logic run on environment activation
    shellHook = ''
      ${displayGreetings}
      ${displayToolsVersions}
    '';
  };
}
