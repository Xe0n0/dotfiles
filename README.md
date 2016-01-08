# dotfiles
Dot files with idempotent bootstrap script

# Components

* `home` All files under this directory will be symbol linked to home dir by creating nessary directories. These makes local modification and sync easier
* `scripts` Scripts that setup states of system
* `bootstrap.sh` The install and bootstrap script. It's idempotent.
