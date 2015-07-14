# .dotfiles

Configurations and preferences that are nice to have, but are painful and irritating to set up over and over again.

## Installation

`git clone <repo_url>` into a desired location.

`cd <repo_dir>`

`./setup.sh`

Then restart your shell, and all the changes should take place (for non-bash configurations, the changes should take place the next time you launch the application).

Note: For further changes to bash after running `./setup.sh` at least once on your machine, running `refresh` will re-source your `.bashrc` and the changes will take place immediately and not require a shell restart.

## Humble Requests

Please put all bash configurations into `.bashrc` and not in `.bash_profile`.

