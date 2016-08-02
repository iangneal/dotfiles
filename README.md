# `.dotfiles`

Configurations and preferences that are nice to have, but are painful and
irritating to set up over and over again.

## Installation

Make sure you have bash >= 4.0 installed

For OSX:

  brew install bash
  sudo -s
  brew ls bash | grep '/bin/bash$' >> /etc/shells
  exit
  chsh -s $(brew ls bash | grep '/bin/bash$') $(whoami)

Run `./setup.sh` to install. Then restart your shell, and all the changes
should take place (for non-bash configurations, the changes should take place
the next time you launch the application).

Note: For further changes to bash after running `./setup.sh` at least once on
your machine, running the `$ refresh` command will re-source the dot files
and the changes will take place immediately and not require a shell restart.

### For those of us new to bash

#### `.bashrc` vs `.bash_profile`

`.bashrc` is for non-login shells, and `.bash_profile` is for login shells.
If you want something to only show up at login, do it in `.bash_profile`,
not `.bashrc`. Otherwise, put it in `.bashrc`

