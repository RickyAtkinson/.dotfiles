# Dotfiles

My dotfiles and configuration scripts.

## Install Scripts

> Please do not use these scripts unless you understand what they do and have edited them for your needs.

Use the install script for the system you are using to automate setup.

- All scripts expects that this project is located at `~/.dotfiles` on Linux based systems or `$Env:USERPROFILE` on Windows.
- `install-windows.ps1` expects to be run in PowerShell core and depends on Git for Windows and VS Code.
- `install-wsl.ps1` expects to be run in a new Ubuntu WSL instance.

## Setup scripts

The setup scripts create symlinks on the system to the config files in this project. The install scripts run all the setup scripts that are needed for the system, but if you add or remove files from a config, you may need to run the relevant script again.
