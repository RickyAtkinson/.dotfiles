# Installs the VS Code dotfiles

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing VS Code configs..."

New-Item -ItemType SymbolicLink `
    -Path "$Env:USERPROFILE\AppData\Roaming\Code\User\settings.json" `
    -Target "$Env:USERPROFILE\.dotfiles\config\vs-code\settings.json" `
    -Force
