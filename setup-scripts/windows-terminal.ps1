# Installs the Windows Terminal dotfiles

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing Windows Terminal configs..."

New-Item -ItemType SymbolicLink `
    -Path "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
    -Target "$Env:USERPROFILE\.dotfiles\config\windows-terminal\settings.json" `
    -Force
