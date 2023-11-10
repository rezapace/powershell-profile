# Cek apakah Winget sudah terinstall
$wingetVersion = winget -v

if ($wingetVersion -eq $null) {
    Write-Host "Winget belum terinstall. Silakan install Winget terlebih dahulu."
    # Tambahkan perintah instalasi Winget di sini jika perlu
    # Contoh: Invoke-Expression "& {$Env:SYSTEMROOT\System32\WindowsPowerShell\v1.0\powershell.exe -Command \"iwr -useb https://aka.ms/install-powershell.ps1 | iex\"}"
    Exit
}

# Jika Winget sudah terinstall, lanjutkan dengan instalasi aplikasi lainnya
winget install -e --id Google.Chrome #chrome
winget install -e --id 7zip.7zip #7zip
winget install -e --id GitHub.GitHubDesktop #github
winget install -e --id Microsoft.PowerToys #powertoys
winget install -e --id OliverSchwendener.ueli #ueli
winget install -e --id Microsoft.VisualStudioCode #vscode
winget install -e --id VideoLAN.VLC #vlc
winget install -e --id 9P1741LKHQS9 #fancy wm