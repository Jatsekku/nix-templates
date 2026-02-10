{ pkgs, ... }:

pkgs.testers.runNixOSTest {
  name = "bash-project-module-test";

  nodes.machine =
    { pkgs, ... }:
    {
      imports = [
        ../module.nix
      ];

      programs.bash-project.enable = true;
    };

  testScript = ''
    machine.wait_for_unit("multi-user.target")

    # check package got installed
    machine.succeed("which bash-project")
  '';
}
