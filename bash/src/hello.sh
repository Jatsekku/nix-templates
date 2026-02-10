#!/run/current-system/sw/bin/bash
# ^ Shebang for non-nix fallback

# Source logger module
# shellcheck disable=SC1090,SC1091
source "${BASH_LOGGER_SH}"
logger_register_module "bash-project" LOG_LEVEL_ALL
logger_set_log_format "%F %T (%mod_name) [%cs%lvl%ce] %msg"
logger_set_log_file "./hello.log"

log_inf "Hello!"

