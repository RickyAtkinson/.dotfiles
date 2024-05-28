# Set encopding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Default Editor
$Env:EDITOR = "nvim"
$Env:VISUAL = "code"

# volta tab-completions
(& volta completions powershell) | Out-String | Invoke-Expression

# Functions
function ..
{
    Set-Location .. 
}
function ...
{
    Set-Location ..\.. 
}
function ....
{
    Set-Location ..\..\.. 
}
function .....
{
    Set-Location ..\..\..\.. 
}
function Set-LocationHome
{
    Set-Location $Env:USERPROFILE 
}
function Set-LocationProjects
{
    Set-Location $Env:USERPROFILE\Projects 
}
function Set-LocationPersonal
{
    Set-Location $Env:USERPROFILE\Projects\Personal 
}
function Set-LocationWork
{
    Set-Location $Env:USERPROFILE\Projects\Work 
}
function Set-LocationTools
{
    Set-Location $Env:USERPROFILE\Projects\Tools 
}
function Set-LocationSandbox
{
    Set-Location $Env:USERPROFILE\Projects\Sandbox 
}
function Set-LocationTutorials
{
    Set-Location $Env:USERPROFILE\Projects\Tutorials 
}
function Set-LocationDotfiles
{
    Set-Location $Env:USERPROFILE\.dotfiles 
}
function Invoke-Artisan
{
    php artisan $Args 
}
function Invoke-GitAdd
{
    git add $Args 
}
function Invoke-GitAddAll
{
    git add . 
}
function Invoke-GitCheckout
{
    git chekcout $Args 
}
function Invoke-GitCommit
{
    git commit $Args 
}
function Invoke-GitCommitMsg
{
    git commit -m $Args 
}
function Invoke-GitFetch
{
    git fetch $Args 
}
function Invoke-GitPush
{
    git push $Args 
}
function Invoke-GitPull
{
    git pull $Args 
}
function Invoke-GitMerge
{
    git merge $Args 
}

# Aliases
Set-Alias -Name ~ -Value Set-LocationHome
Set-Alias -Name art -Value Invoke-Artisan
Set-Alias -Name artisan -Value Invoke-Artisan
Set-Alias -Name btw -Value neofetch
Set-Alias -Name cat -Value "C:\Program Files\Git\usr\bin\cat.exe"
Set-Alias -Name cheatsh -Value cht-sh.ps1
Set-Alias -Name cht-sh -Value cht-sh.ps1
Set-Alias -Name chtsh -Value cht-sh.ps1
Set-Alias -Name dotfiles -Value Set-LocationDotfiles
Set-Alias -Name g -Value git
Set-Alias -Name ga -Value Invoke-GitAdd
Set-Alias -Name gaa -Value Invoke-GitAddAll
Set-Alias -Name gco -Value Invoke-GitCheckout
Set-Alias -Name gc -Value Invoke-GitCommit -Force
Set-Alias -Name gcm -Value Invoke-GitCommitMsg -Force
Set-Alias -Name gfet -Value Invoke-GitFetch
Set-Alias -Name gp -Value Invoke-GitPush -Force
Set-Alias -Name gl -Value Invoke-GitPull -Force
Set-Alias -Name gm -Value Invoke-GitMerge -Force
Set-Alias -Name htop -Value ntop
Set-Alias -Name ll -Value ls
Set-Alias -Name projects -Value Set-LocationProjects
Set-Alias -Name tig -Value "C:\Program Files\Git\usr\bin\tig.exe"
Set-Alias -Name work -Value Set-LocationWork

# Vi mode
function OnViModeChange
{
    if ($args[0] -eq 'Command')
    {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[2 q"
    } else
    {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}

# PSReadLine
$PSReadLineOptions = @{
    PredictionSource = "History"
    EditMode = "Vi"
    ViModeIndicator = "Script"
    ViModeChangeHandler = $Function:OnViModeChange
    HistorySearchCursorMovesToEnd = $true
    BellStyle = "Visual"
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Chord "UpArrow" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "DownArrow" -Function HistorySearchForward

Set-PSReadLineKeyHandler -Chord 'Alt+[' -Function ViCommandMode
Set-PSReadLineKeyHandler -Chord 'Ctrl+[' -Function ViCommandMode

# PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider "Ctrl+t" -PSReadlineChordReverseHistory "Ctrl+r"
