# .dotfiles

Configurations and preferences that are nice to have, but are painful and 
irritating to set up over and over again.

## Installation

Make sure you have bash >= 4.0 installed 

For Mac: 

```
brew install bash
sudo -s
brew ls bash | grep '/bin/bash$' >> /etc/shells
exit
chsh -s $(brew ls bash | grep '/bin/bash$') $(whoami)
```

`git clone https://github.com/Dahca/dotfiles.git` into a desired location.

`cd <repo_dir>`

`./setup.sh`

Then restart your shell, and all the changes should take place 
(for non-bash configurations, the changes should take place 
the next time you launch the application).

Note: For further changes to bash after running `./setup.sh` at least once on 
your machine, running `refresh` will re-source your `.bashrc` and the changes 
will take place immediately and not require a shell restart.

### For those of us new to bash

#### .bashrc vs .bash\_profile

.bashrc is for non-login shells, and .bash_profile is for login shells.
If you want something to only show up at login, do it in .bash_profile,
not .bashrc. Otherwise, put it in .bashrc
 
