{ pkgs, ... }:

pkgs.testers.runNixOSTest {
  name = "c-project-module-test";

  nodes.machine =
    { pkgs, ... }:
    {
      imports = [
        ../module.nix
      ];

      programs.c-project.enable = true;
    };

  testScript = ''
    machine.wait_for_unit("multi-user.target")

    # check package got installed
    machine.succeed("which c-project")
  '';
}
