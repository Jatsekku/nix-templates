{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bash-project;
in
{
  options.programs.bash-project = {
    enable = lib.mkEnableOption "Bash project";

    package = lib.mkPackageOption pkgs "bash-project" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
