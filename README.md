# dotfiles
Dot files with idempotent bootstrap script

# Components

* `home` All files and directories under this directory will be *directly* copied to home dir. These makes local modification and sync easier
* `scripts` Scripts that setup states of system
* `bootstrap.sh` The install and bootstrap script. It's idempotent.
