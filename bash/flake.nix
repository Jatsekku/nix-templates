{
  description = "Nix flake templaate for bash application";

  # Flake inputs
  inputs = {
    # Bash logger library
    bash-logger = {
      url = "github:Jatsekku/bash-logger";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    inputs@{ self, ... }:
    let
      # List of all supported systems
      supportedSystems = inputs.nixpkgs.lib.systems.flakeExposed;

      # Function for providing system-specific attributes
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            # Nixpkgs configured per system
            pkgs = import inputs.nixpkgs {
              inherit system;
              # Allow usage of unfree packages
              config.allowUnfree = true;
              # Apply overlays defined by flake itself
              overlays = [ self.overlays.default ];
            };
            inherit system;
          }
        );

    in
    {
      # Provide packages
      packages = forEachSupportedSystem (
        { pkgs, system }:
        let
          # Dependencies
          bash-logger = inputs.bash-logger.packages.${system}.default;
          # Build package
          bash-project-pkg = pkgs.callPackage ./nix/package.nix {
            inherit bash-logger;
          };
        in
        {
          # Expose package
          bash-project = bash-project-pkg;
          default = bash-project-pkg;
        }
      );

      # Inject packages via overlays
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) bash-project;
      };

      # Provide NixOs modules
      nixosModules = {
        bash-project = import ./nix/module.nix;
        default = self.nixosModules.bash-project;
      };

      # Add Nix checks
      checks = forEachSupportedSystem (
        { pkgs, ... }:
        {
          module-test = import ./nix/test/module-test.nix { inherit pkgs; };
        }
      );

      # Generate devShell for each system
      devShells = forEachSupportedSystem ({ pkgs, ... }: import ./nix/devshell.nix { inherit pkgs; });

      # Set formatter for Nix
      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
