# Installs the PHP dotfiles

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing PowerShell configs..."

New-Item -ItemType SymbolicLink `
    -Path "$Env:USERPROFILE\scoop\persist\php\cli\conf.d\extensions.ini" `
    -Target "$Env:USERPROFILE\.dotfiles\config\php\scoop-php8-extensions.ini" `
    -Force

New-Item -ItemType SymbolicLink `
    -Path "$Env:USERPROFILE\scoop\persist\php81\cli\conf.d\extensions.ini" `
    -Target "$Env:USERPROFILE\.dotfiles\config\php\scoop-php8-extensions.ini" `
    -Force

New-Item -ItemType SymbolicLink `
    -Path "$Env:USERPROFILE\scoop\persist\php74\cli\conf.d\extensions.ini" `
    -Target "$Env:USERPROFILE\.dotfiles\config\php\scoop-php7-extensions.ini" `
    -Force
