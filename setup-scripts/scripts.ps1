# Installs scripts

. $Env:USERPROFILE\.dotfiles\config\scripts\lib\utils.ps1

Write-HostInfo "Installing user scripts..."

$dotfileDir="$Env:USERPROFILE\.dotfiles\config\scripts"
$configDir="$Env:LOCALAPPDATA\Scripts"

# Cleanup to avoid broken links hanging around
if (Test-Path "$configDir\*")
{
    Remove-Item -Recurse "$configDir\*"
}

if (!(Test-Path "$configDir\lib" -PathType Container))
{
    New-Item -ItemType Directory -Force -Path "$configDir\lib"
}

Get-ChildItem "$dotfileDir\*.ps1", "$dotfileDir\lib\*" |
    ForEach-Object {
        $dotfileName = $_.FullName
        $configFileName= $configDir + $_.FullName.Replace($dotfileDir, "")

        New-Item -ItemType SymbolicLink `
            -Path "$configFileName" `
            -Target "$dotfileName" `
            -Force
    }
