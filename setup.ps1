if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
        if ($PSVersionTable.PSEdition -eq "Core" ) { 
            if (!(Test-Path -Path ($env:userprofile + "\Documents\Powershell"))) {
                New-Item -Path ($env:userprofile + "\Documents\Powershell") -ItemType "directory"
            }
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            if (!(Test-Path -Path ($env:userprofile + "\Documents\WindowsPowerShell"))) {
                New-Item -Path ($env:userprofile + "\Documents\WindowsPowerShell") -ItemType "directory"
            }
        }
        Invoke-RestMethod https://github.com/rezapace/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -o $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
}
else {
		Get-Item -Path $PROFILE | Move-Item -Destination oldprofile.ps1 -Force
		Invoke-RestMethod https://github.com/rezapace/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE
		Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
}
& $profile
winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families
if ($fontFamilies -notcontains "CaskaydiaCove NF") {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile("https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip", ".\CascadiaCode.zip")

    Expand-Archive -Path ".\CascadiaCode.zip" -DestinationPath ".\CascadiaCode" -Force
    $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
    Get-ChildItem -Path ".\CascadiaCode" -Recurse -Filter "*.ttf" | ForEach-Object {
        If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
            # Install font
            $destination.CopyHere($_.FullName, 0x10)
        }
    }
    Remove-Item -Path ".\CascadiaCode" -Recurse -Force
    Remove-Item -Path ".\CascadiaCode.zip" -Force
}
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalasi modul-modul yang dibutuhkan
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name posh-git -Scope CurrentUser -Force
Install-Module -Name PowerShellGet -Scope CurrentUser -Force
Install-Module -Name z -Scope CurrentUser -Force
install-Module -Name PSReadLine CurrentUser -Force
scoop install fzf -y
choco install gsudo -y