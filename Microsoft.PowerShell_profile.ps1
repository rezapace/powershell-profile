#  ██╗    ██╗███████╗██████╗ ██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ ██╗     
#  ██║    ██║██╔════╝██╔══██╗██║ ██╔╝██║   ██║████╗ ████║██╔══██╗██║     
#  ██║ █╗ ██║█████╗  ██████╔╝█████╔╝ ██║   ██║██╔████╔██║███████║██║     
#  ██║███╗██║██╔══╝  ██╔══██╗██╔═██╗ ██║   ██║██║╚██╔╝██║██╔══██║██║     
#  ╚███╔███╔╝███████╗██████╔╝██║  ██╗╚██████╔╝██║ ╚═╝ ██║██║  ██║███████╗
#   ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝

Import-Module -Name Terminal-Icons

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }
function n { notepad $args }
function HKLM: { Set-Location HKLM: }
function HKCU: { Set-Location HKCU: }
function Env: { Set-Location Env: }

if (Test-Path "$env:USERPROFILE\Work Folders") {
    New-PSDrive -Name Work -PSProvider FileSystem -Root "$env:USERPROFILE\Work Folders" -Description "Work Folders"
function Work: { Set-Location Work: }}

function prompt {
if ($isAdmin) {
"[" + (Get-Location) + "] # "
} else {
"[" + (Get-Location) + "] $ "
}}
$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin) {
$Host.UI.RawUI.WindowTitle += " [ADMIN]"}

function dirs {
if ($args.Count -gt 0) {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
} else {
Get-ChildItem -Recurse | Foreach-Object FullName
}}

function admin {
if ($args.Count -gt 0) {
        $argList = "& '" + $args + "'"
        Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "$psHome\powershell.exe" -Verb runAs
}}

Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

function Edit-Profile {
if ($host.Name -match "ise") {
        $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
} else {
notepad $profile.CurrentUserAllHosts
}}

Remove-Variable identity
Remove-Variable principal

Function Test-CommandExists {
Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    try { if (Get-Command $command) { RETURN $true } }
    Catch { Write-Host "$command does not exist"; RETURN $false }
Finally { $ErrorActionPreference = $oldPreference }}
if (Test-CommandExists nvim) {
$EDITOR='nvim'
} elseif (Test-CommandExists pvim) {
$EDITOR='pvim'
} elseif (Test-CommandExists vim) {
$EDITOR='vim'
} elseif (Test-CommandExists vi) {
$EDITOR='vi'
} elseif (Test-CommandExists code) {
$EDITOR='code'
} elseif (Test-CommandExists notepad) {
$EDITOR='notepad'
} elseif (Test-CommandExists notepad++) {
$EDITOR='notepad++'
} elseif (Test-CommandExists sublime_text) {
$EDITOR='sublime_text'
}

Set-Alias -Name vim -Value $EDITOR
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows





#  ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗     ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗
#  ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝    ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║
#  ███████╗██║     ██████╔╝██║██████╔╝   ██║       ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║
#  ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║       ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║
#  ███████║╚██████╗██║  ██║██║██║        ██║       ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║
#  ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝        ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝   





function ll { Get-ChildItem -Path $pwd -File }
function g { Set-Location $HOME\Documents\Github }
function desktop { Set-Location $HOME\Desktop }
function htdoc { Set-Location c:\xampp\htdocs }
function src { Set-Location 'C:\Program Files\Go\src' }
function home { Set-Location 'C:\' }
function linux { Set-Location '\\wsl$\Ubuntu-20.04\home\r' }
function c {Clear}
function e {explorer .}
function v {code .}
function rprofile {& $profile}
function profile {code 'C:\Users\R\Documents\WindowsPowerShell'}

function com {
git add .
git commit -m "$args"
}

function up {
    git add .
    git commit -m "$args"
    git push
}

function Get-PubIP {
(Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function uptime {
Get-WmiObject win32*operatingsystem | Select-Object csname, @{
LABEL = 'LastBootUpTime';
EXPRESSION = { $*.ConverttoDateTime($\_.lastbootuptime) }
}}

function find-file($name) {
Get-ChildItem -recurse -filter "_${name}_" -ErrorAction SilentlyContinue | ForEach-Object {
$place_path = $_.directory
        Write-Output "${place*path}\${*}"
}}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function zip {
    param(
        [Parameter(Mandatory=$true)]
[string]$name
    )
    $path = (Get-Location).Path
    Compress-Archive -Path "$path\*" -DestinationPath "$path\..\$name.zip"
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function touch($file) {
"" | Out-File $file -Encoding ASCII
}

function df {
    get-volume
}

function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function which($name) {
Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
Get-Process $name
}

function konek {
param(
[Parameter(Mandatory=$true)]
[string]$ip,
        [int]$listenport = 8000,
[int]$connectport = 8000
    )
    $listenaddress = $ip.Trim()
    $connectaddress = $($(wsl hostname -I).Trim())
$cmd = "netsh interface portproxy add v4tov4 listenport=$listenport listenaddress=$listenaddress connectport=$connectport connectaddress=$connectaddress"
Invoke-Expression $cmd
}

function stop {
netsh interface portproxy reset
}

function cek {
netsh interface portproxy show v4tov4
}

function web {
$folderName = Split-Path -Leaf (Get-Location)
    $filePath = "C:\xampp\htdocs\$folderName"
    $url = "http://localhost/$folderName/"
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    & $chromePath $url
}

function local {
    $url = "http://localhost/phpmyadmin/"
    $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    & $chromePath $url
}

function xampprun {
    Set-Location 'C:\xampp'
    Start-Process 'apache_start.bat' -WindowStyle Minimized
    Start-Process 'mysql_start.bat' -WindowStyle Minimized
}

function xamppstop {
    Set-Location 'C:\xampp'
    taskkill /f /im httpd.exe
    & '.\mysql\bin\mysqladmin.exe' -u root shutdown
}

function mysql {
    & 'C:\xampp\mysql\bin\mysql.exe' -u root -p
}

function j {
param(
[string]$DirectoryName
)
    Set-Location 'C:\'
    Invoke-Expression "z $DirectoryName"
}

function linuxstop {
wsl.exe --terminate ubuntu-20.04
}

function linuxstat {
wsl --list -v
}

function cirun {
php spark serve
}

function cp {
$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $fileName = Read-Host "Enter the file name to copy"
    $sourceFilePath = Join-Path $currentDir $fileName
    if (-not (Test-Path $sourceFilePath)) {
        Write-Host "Error: $fileName not found in $currentDir" -ForegroundColor Red
        return
    }
    $destFileName = Read-Host "Enter the destination file name"
    $destFilePath = Join-Path $currentDir $destFileName
    Copy-Item $sourceFilePath $destFilePath
    if (Test-Path $destFilePath) {
        Write-Host "$fileName copied to $destFilePath" -ForegroundColor Green
    } else {
        Write-Host "Error: $fileName copy to $destFilePath failed" -ForegroundColor Red
    }
}

function mv { # Get current PowerShell directory
$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $fileName = Read-Host "Enter the file name to move"
    $sourceFilePath = Join-Path $currentDir $fileName
    if (-not (Test-Path $sourceFilePath)) {
        Write-Host "Error: $fileName not found in $currentDir" -ForegroundColor Red
        return
    }
    $destFileName = Read-Host "Enter the destination file name"
    $destFilePath = Join-Path $currentDir $destFileName
    Move-Item $sourceFilePath $destFilePath
    Write-Host "$fileName moved to $destFilePath"
}

function gr {
$url = "https://github.com/rezapace?tab=repositories"
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
& $chromePath $url
}

function hp {
cd C:\scrcpy-win64-v2.0
.\scrcpy -m720 -b30m
}

$script:OpenAI_Key = "isi api nya"
function ask
{
param(
[string]$question,
        [int]$tokens = 500,
[switch]$return
)
$key = $script:openai_key
$url = "https://api.openai.com/v1/completions"
    $body = [pscustomobject]@{
        "model" = "text-davinci-003"
        "prompt"      = "$question"
        "temperature"   = .2
        "max_tokens"=$tokens
        "top_p"=1
        "n"=1
        "frequency_penalty"= 1
        "presence_penalty"= 1
    }
    $header = @{
        "Authorization" = "Bearer $key"
        "Content-Type"  = "application/json"
    }
    $bodyJSON  = ($body | ConvertTo-Json -Compress)
    try
    {
        $res = Invoke-WebRequest -Headers $header -Body $bodyJSON -Uri $url -method post
        if ($PSVersionTable.PSVersion.Major -ne 5) {
            $output = ($res | convertfrom-json -Depth 3).choices.text.trim()
        }else{
            $output = ($res | convertfrom-json).choices.text.trim()
        }
        $formattedOutput = "# " + $question + " " + $output
        if ($return)
        {
            return $formattedOutput
        } else
        {
            write-host $formattedOutput
        }
    } catch
    {
        write-error $_.exception
    }
}

function remove {
    try {
        Write-Host "Menghapus file-file sementara temp..." -NoNewLine -ForegroundColor Yellow
        Get-ChildItem -Path "C:\Windows\Temp" -Filter *.* -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "Selesai." -ForegroundColor Green

        $userTempPath = $env:TEMP
        Write-Host "Menghapus file-file sementara dari $userTempPath..." -NoNewLine -ForegroundColor Yellow
        Get-ChildItem -Path $userTempPath -Filter *.* -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "Selesai." -ForegroundColor Green

        Write-Host "Menghapus file-file Prefetch dari Prefetch..." -NoNewLine -ForegroundColor Yellow
        Get-ChildItem -Path "C:\Windows\Prefetch" -Filter *.* | Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Host "Selesai." -ForegroundColor Green

        Write-Host "Mengosongkan Recycle Bin..." -NoNewLine -ForegroundColor Yellow
        Clear-RecycleBin -Force -Confirm:$false -ErrorAction SilentlyContinue
        Write-Host "Selesai." -ForegroundColor Green

        Write-Host "Menjalankan Disk Cleanup..." -NoNewLine -ForegroundColor Yellow
        Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/d C: /VERYLOWDISK" -NoNewWindow -Wait
        Write-Host "Selesai." -ForegroundColor Green
        
        Write-Host "Semua file-file yang ditargetkan telah dihapus." -ForegroundColor Cyan
    }
    catch {
        Write-Host "Terjadi kesalahan saat menghapus file: $($_.Exception.Message)" -ForegroundColor Red
    }
}




#    ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗
#   ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║
#   ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║
#   ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║
#   ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║
#    ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝

# function gabung {
#     $folder = Get-Location
#     $pdfs = Get-ChildItem -Path $folder -Filter *.pdf | Select-Object -ExpandProperty FullName
#     $output = Join-Path -Path $folder -ChildPath "output.pdf"
#     & "C:\Program Files\gs\gs10.00.0\bin\gswin64c.exe" -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dQUIET -sOutputFile="$output" $pdfs
# }


# function opdf {
#     [CmdletBinding()]
#     param(
#         [Parameter(Mandatory=$true, Position=0)]
# [string]$InputFile,

#         [Parameter(Mandatory=$true, Position=1)]
#         [string]$OutputFile
#     )
#     $arguments = @(
#         "-sDEVICE=pdfwrite",
#         "-dCompatibilityLevel=1.4",
#         "-dPDFSETTINGS=/screen",
#         "-dNOPAUSE",
#         "-dQUIET",
#         "-dBATCH",
#         "-sOutputFile=$OutputFile",
#         $InputFile
#     )
#     &"C:\Program Files\gs\gs9.54.0\bin\gswin64c.exe" @arguments
#     if (Test-Path $OutputFile) {
#         return $true
#     }
#     else {
#         return $false
#     }

# }

# function p2w { # Load Aspose.PDF DLL
# Add-Type -Path "C:\Program Files (x86)\Aspose\Aspose.PDF for .NET\Bin\net4.0\Aspose.PDF.dll"
#     $pdfFile = Read-Host "Enter the PDF file location and name (e.g. C:\Folder\a.pdf)"
#     $doc = New-Object Aspose.Pdf.Document($pdfFile)
#     $saveOptions = New-Object Aspose.Pdf.DocSaveOptions
#     $saveOptions.Format = "DocX"
#     $outputFolder = Split-Path $pdfFile
#     $outputFile = Join-Path $outputFolder "output.docx"
#     $doc.Save($outputFile, $saveOptions)
#     Write-Host "PDF file converted to DOCX. Output file: $outputFile"
# }

# function Invoke-PecoHistory {
# $command = Get-History | peco | select -expandproperty CommandLine
# if ($command) {
# Invoke-Expression $command
# }
# }
# Set-PSReadLineKeyHandler -Key Ctrl+f -ScriptBlock ${function:Invoke-PecoHistory}


oh-my-posh init pwsh --config 'C:/Users/R/Documents/GitHub/powershell-profile/rezapace.theme.omp.json' | Invoke-Expression

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
