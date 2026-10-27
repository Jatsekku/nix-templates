# This file is responsible for setting dev environment
# It defines binaries that will be provided and logic that will be run
# when 'nix develop .' will be executed
{ pkgs }:
let
  displayToolsVersions = ''
    printf '%.0s-' {1..80}; printf '\n'

    printf '%.0s-' {1..80}; printf '\n'
  '';

  displayGreetings = ''
    echo "nRF environment"
  '';
in
{
  default = pkgs.mkShell {
    # Nix packages provided in environment
    buildInputs = with pkgs; [
      (nrfutil.withExtensions [
        "nrfutil-91"
        "nrfutil-ble-sniffer"
        "nrfutil-completion"
        "nrfutil-device"
        "nrfutil-mcu-manager"
        "nrfutil-npm"
        "nrfutil-nrf5sdk-tools"
        "nrfutil-sdk-manager"
        "nrfutil-suit"
        "nrfutil-toolchain-manager"
        "nrfutil-trace"
      ])
    ];

    # Logic run on environment activation
    shellHook = ''
      ${displayGreetings}
      ${displayToolsVersions}
    '';
  };
}
