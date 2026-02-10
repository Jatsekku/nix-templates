{ pkgs, bash-logger }:
let
  # Path to external lib (bash-logger)
  bash-logger-scriptPath = bash-logger.passthru.scriptPath;

  # Path to script
  bash-project-scriptPath = ../src/hello.sh;
  # Content of the sript
  bash-project-scriptContent = builtins.readFile bash-project-scriptPath;
in
pkgs.writeShellApplication {
  name = "bash-project";
  text = ''
    # Provide path to bash-logger library
    export BASH_LOGGER_SH=${bash-logger-scriptPath}

    ${bash-project-scriptContent}
  '';

  # Runtime dependencies for package
  runtimeInputs = [
    pkgs.bash
    bash-logger
  ];

  # Metdata propagation
  passthru = {
    # Expose path to script (usefull for shell "libraries")
    scriptPath = bash-project-scriptPath;
  };
}
