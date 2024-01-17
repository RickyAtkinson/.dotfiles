# Installs the neovim dotfiles

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing Neovim configs..."

$dotfileDir = "$Env:USERPROFILE\.dotfiles\config\neovim"
$configDir="$Env:LOCALAPPDATA\nvim"

# Cleanup to avoid broken links hanging around
if (Test-Path "$configDir\init.lua")
{
    Remove-Item "$configDir\init.lua"
}
if (Test-Path "$configDir\lua\*\*.lua")
{
    Remove-Item "$configDir\lua\*\*.lua"
}

if (!(Test-Path "$configDir\lua\config" -PathType Container))
{
    New-Item -ItemType Directory -Force -Path "$configDir\lua\config"
}
if (!(Test-Path "$configDir\lua\plugins" -PathType Container))
{
    New-Item -ItemType Directory -Force -Path "$pluginsDir\lua\config"
}
if (!(Test-Path "$configDir\lua\utils" -PathType Container))
{
    New-Item -ItemType Directory -Force -Path "$configDir\lua\utils"
}

Get-ChildItem "$dotfileDir\init.lua", "$dotfileDir\lua\*\*.lua" |
    ForEach-Object {
        $dotfileName = $_.FullName
        $configFileName= $configDir + $_.FullName.Replace($dotfileDir, "")

        New-Item -ItemType SymbolicLink `
            -Path "$configFileName" `
            -Target "$dotfileName" `
            -Force
    }
