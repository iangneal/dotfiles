# .dotfiles

Configurations and preferences that are nice to have, but are painful and irritating to set up over and over again.

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

Then restart your shell, and all the changes should take place (for non-bash configurations, the changes should take place the next time you launch the application).

Note: For further changes to bash after running `./setup.sh` at least once on your machine, running `refresh` will re-source your `.bashrc` and the changes will take place immediately and not require a shell restart.

## Humble Requests

Please put all bash configurations into `.bashrc` and not in `.bash_profile`.

