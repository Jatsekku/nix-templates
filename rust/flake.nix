{
  description = "Nix flake for rust development";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      # List of all supported systems
      supportedSystems = nixpkgs.lib.systems.flakeExposed;

      # Function for providing system-specific attributes
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            # Nixpkgs configured per system
            pkgs = import nixpkgs {
              inherit system;
              # Allow usage of unfree packages
              config.allowUnfree = true;
            };
          }
        );

      displayToolsVersions = ''
        printf '%.0s-' {1..80}; printf '\n'

        cargo -V
        clippy-driver -V
        rustc -V
        rustfmt -V
        rust-analyzer -V

        printf '%.0s-' {1..80}; printf '\n'
      '';

      displayGreetings = ''
        echo "Rust environment 🦀"
      '';
    in
    {
      # Generate devShell for each system
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            # Nix packages provided in environment
            buildInputs = with pkgs; [
              cargo
              clippy
              rustc
              rustfmt
              rust-analyzer
            ];

            # Environment variables
            env = {
              RUST_SRC_PATH = pkgs.rust.packages.stable.rustPlatform.rustLibSrc;
            };

            # Logic run on environment activation
            shellHook = ''
              ${displayGreetings}
              ${displayToolsVersions}
            '';
          };
        }
      );

      # Set formatter for Nix
      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt);
    };
}
