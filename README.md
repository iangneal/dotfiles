# `.dotfiles`

Configurations and preferences that are nice to have, but are painful and
irritating to set up over and over again.

## Installation

### Bash

Make sure you have bash >= 4.0 installed

For OSX:

    brew install bash
    sudo brew ls bash | grep '/bin/bash$' >> /etc/shells
    chsh -s $(brew ls bash | grep '/bin/bash$') $(whoami)

### Dot file installation

    bash setup.sh
    # Now restart your shell

For non-bash configuration files (like `.vimrc`, the changes should take place
the next time you launch the application).

_Note_: If you modify the `.bashrc` after doing the initial setup, just run the
following:

    $ refresh

And this will re-source the `.bashrc` and the changes will take place
immediately and not require a shell restart.

### For those of us new to bash

#### `.bashrc` vs `.bash_profile`

`.bashrc` is for non-login shells, and `.bash_profile` is for login shells.
If you want something to only show up at login, do it in `.bash_profile`,
not `.bashrc`. Otherwise, put it in `.bashrc`

