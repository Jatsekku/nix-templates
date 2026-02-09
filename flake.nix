{
  description = "Jatsekku's flake templates";

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
    in
    {
      templates = { };

      # Set formatter for Nix
      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt);
    };
}
