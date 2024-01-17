# Installs the PowerShell dotfiles

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing PowerShell configs..."

New-Item -ItemType SymbolicLink `
    -Path "$PROFILE" `
    -Target "$Env:USERPROFILE\.dotfiles\config\powershell\PowerShell_profile.ps1" `
    -Force
