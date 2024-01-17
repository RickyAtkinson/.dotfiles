# Searchs cheat.sh and displays the results in less

. $Env:LOCALAPPDATA\Scripts\lib\utils.ps1

$scriptsPath = "$Env:LOCALAPPDATA\Scripts"
$gitBin = "C:\Program Files\Git\usr\bin"

$selected = $(& "$gitBin\cat.exe" `
        "$scriptsPath\lib\cht-sh-commands" "$scriptsPath\lib\cht-sh-languages" | fzf)

if ([string]::IsNullOrEmpty($selected))
{
    exit
}

$query = Read-Host -Prompt "Query"

if (Select-String -Pattern "$selected" `
        -Path "$scriptsPath\lib\cht-sh-languages" -Quiet)
{
    $query = $query -replace " ", "+"
    $output = curl --silent "cht.sh/$selected/$query"
    $output | & "$gitBin\less" -R
} else
{
    $output = curl --silent "cht.sh/$selected~$query"
    $output | & "$gitBin\less" -R
}
