# Windows setup script

. .\config\scripts\lib\utils.ps1

function Get-LatestGithubReleaseNumber
{
    $param1 = $Args[0]
    curl --silent "https://api.github.com/repos/$param1/releases/latest" |
        grep '"tag_name":' | # Get tag line
        sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

# Check for requirements
if ($PSVersionTable.PSEdition -ne "Core")
{
    Write-HostError "This script is made to be run inside PowerShell Core. Exiting."
    exit
}

Write-HostInfo "Configuring git..."
$inputLoop = $true
while ($inputLoop)
{
    $gitName = Read-Host -Prompt "Enter your git user.name"
    $gitEmail = Read-Host -Prompt "Enter your git user.email"

    Write-Host "`ngit user.name: $gitName"
    Write-Host "git user.email: $gitEmail`n"
    $gitConfirm = Read-Host -Prompt "Is that correct? (y/N):"

    $gitConfirm = $gitConfirm.ToLower()
    if ($gitConfirm -eq "y" -or $gitConfirm -eq "yes")
    {
        $inputLoop = $false
    }
}
git config --global user.name "$gitName"
git config --global user.email "$gitEmail"
git config --global core.autocrlf input
git config --global core.pager "diff-so-fancy | less --tabs=2 -RFXS --pattern '^(Date|added|deleted|modified): '"
git config --global init.defaultBranch main
git config --global push.default current

Write-HostInfo "Creating project folders..."
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Personal" -Force
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Sandbox" -Force
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Tools" -Force
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Tutorials" -Force
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Work" -Force
New-Item -ItemType "directory" -Path "$Env:USERPROFILE\Projects\Library" -Force

Write-HostInfo "Installing Winget packages..."
winget install Microsoft.PowerToys --source winget
winget install --id=MiKTeX.MiKTeX -e
winget install --id=JohnMacFarlane.Pandoc -e

Write-HostInfo "Installing Scoop package manager..."
Invoke-RestMethod get.scoop.sh | Invoke-Expression

Write-HostInfo "Adding Scoop buckets..."
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

Write-HostInfo "Installing Scoop packages..."
# Install aria2 first so scoop can use it for future downloads
scoop install aria2
scoop config aria2-warning-enabled false

scoop install `
    bat `
    btop `
    cacert `
    composer `
    diff-so-fancy `
    dos2unix `
    fd `
    ffmpeg `
    file `
    fx `
    fzf `
    gawk `
    go `
    graphicsmagick `
    grep `
    imagemagick `
    lazygit `
    less `
    lua `
    luajit `
    luarocks `
    neofetch `
    neovim `
    nerd-fonts/Meslo-NF `
    ntop `
    php `
    php74 `
    php81 `
    python `
    ripgrep `
    sed `
    sudo `
    tar `
    tldr `
    touch `
    unzip `
    volta `
    wget `
    which `
    zoxide

Write-HostInfo "Setting default PHP version to latest..."
scoop reset php

Write-HostInfo "Installing Node and package managers..."
$Env:VOLTA_FEATURE_PNPM = 1
volta install node
volta install yarn
volta install pnpm

Write-Host "Installing global node packages..."
npm install -g degit tree-sitter-cli

Write-HostInfo "Installing pyvim for Neovim Python support..."
python3 -m pip install --user --upgrade pynvim

Write-HostInfo "Installing gopls..."
go install -v golang.org/x/tools/gopls@latest

Write-HostInfo "Installing PowerShell Modules..."
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop
Install-Module -Name PSFzf -Scope CurrentUser

Write-HostInfo "Installing VS Code Extensions..."
$extensions = Get-Content -Path .\setup-scripts\lib\vscode-extensions
ForEach ($extension in $extensions)
{
    code --install-extension $extension
}

Write-HostInfo "Getting git repos..."
git clone git@github.com:RickyAtkinson/.notes.git $Env:USERPROFILE\Documents\.notes

Write-HostInfo "Installing dotfiles..."
.\setup-scripts\neovim.ps1
.\setup-scripts\php.ps1
.\setup-scripts\powershell.ps1
.\setup-scripts\scripts.ps1
.\setup-scripts\vs-code.ps1
.\setup-scripts\windows-terminal.ps1

Write-HostInfo "Downloading Eisvogel latex theme..."
$eisvogelVersion = Get-LatestGithubReleaseNumber "Wandmalfarbe/pandoc-latex-template"
$eisvogelFolderName = "Eisvogel-$eisvogelVersion"
wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/$eisvogelVersion/$eisvogelFolderName.zip `
    -O $Env:USERPROFILE\Downloads\$eisvogelFolderName.zip
unzip $Env:USERPROFILE\Downloads\$eisvogelFolderName.zip -d $Env:USERPROFILE\Downloads\$eisvogelFolderName
if (!(Test-Path "$Env:USERPROFILE\AppData\Roaming\pandoc\templates" -PathType Container))
{
    New-Item -ItemType "directory" -Path "$Env:USERPROFILE\AppData\Roaming\pandoc\templates" -Force
}
Move-Item -Path "$Env:USERPROFILE\Downloads\$eisvogelFolderName\eisvogel.latex" `
    -Destination "$Env:USERPROFILE\AppData\Roaming\pandoc\templates\eisvogel.latex"
Remove-Item -Recurse $Env:USERPROFILE\Downloads\$eisvogelFolderName
Remove-Item -Recurse $Env:USERPROFILE\Downloads\$eisvogelFolderName.zip

Write-HostInfo "To be able to use the scripts installed during setup from the command line, you will need to add ``" + $Env:LOCALAPPDATA + "\Scripts`` to your PATH. This can be done easily with Windows PowerToys, which was installed during setup."

Write-HostSuccess "Windows Setup is complete! Reload your terminal to complete."
