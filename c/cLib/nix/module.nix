{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.c-project;
in
{
  options.programs.c-project = {
    enable = lib.mkEnableOption "c project";

    package = lib.mkPackageOption pkgs "c-project" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
