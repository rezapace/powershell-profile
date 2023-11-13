
# Instalasi

Ikuti langkah-langkah berikut untuk menginstal dan menjalankan skrip optimasi pada mesin Windows Anda:

1. **Pindahkan Skrip ke Local Disk C:**
   - Pindahkan semua file skrip ke root Local Disk C: untuk memudahkan akses.

2. **Buka PowerShell sebagai Administrator**
   - Klik kanan pada ikon PowerShell dan pilih "Jalankan sebagai Administrator."

3. **Navigasi ke Local Disk C:**
   - Di jendela PowerShell, ketik perintah berikut dan tekan Enter:

     ```powershell
     cd C:\
     ```

4. **Atur Kebijakan Eksekusi**
   - Jalankan perintah berikut untuk mengatur kebijakan eksekusi:

     ```powershell
     Set-ExecutionPolicy Unrestricted -Scope CurrentUser
     ```

5. **Terima Perubahan Kebijakan Eksekusi**
   - Ketik 'A' dan tekan Enter untuk menerima perubahan.

6. **Unblock File Skrip**
   - Jalankan perintah berikut untuk membuka blokir semua file skrip di direktori C:\. Catatan: Proses ini mungkin memakan waktu.

     ```powershell
     ls -Recurse *.ps*1 | Unblock-File
     ```

7. **Navigasi ke Folder Skrip**
   - Pindah ke folder yang berisi skrip dengan menggunakan:

     ```powershell
     cd SCRIPTS
     ```

8. **Jalankan Skrip Tertentu**
   - Jalankan skrip tertentu dengan mengetikkan namanya. Contohnya:

     ```powershell
     .\block-telemetry.ps1
     ```

   - Gunakan tombol Tab untuk otomatisasi penulisan.

9. **Ikuti Petunjuk di Layar**


# Scripts


1. **block-telemetry.ps1**
   - *Description*: Gathers and blocks data uploaded to Microsoft for enhanced privacy.
   
2. **disable-services.ps1**
   - *Description*: Disables unnecessary services related to telemetry.

3. **disable-windows-defender.ps1**
   - *Description*: Removes Windows Defender for users who prefer alternative security solutions.

4. **experimental_unfuckery.ps1**
   - *Description*: Disables built-in applications like Cortana for a streamlined experience.

5. **fix-privacy-settings.ps1**
   - *Description*: Disables default Windows applications to improve privacy settings, including location services.

6. **optimize-user-interface.ps1**
   - *Description*: Speeds up Windows by disabling unnecessary animations in the user interface.

7. **optimize-windows-update.ps1**
   - *Description*: Customizes Windows Update to provide notifications before downloading updates.

8. **remove-default-apps.ps1**
   - *Description*: Removes rarely used default applications, leaving the option for manual uninstallation of the remaining ones.

9. **remove-onedrive.ps1**
   - *Description*: Disables OneDrive integration for users who do not use or prefer alternative cloud storage.


10)	RUN AS ADMINIST TRATOR 
     ```powershell
     Windows10 Boost.bat 
     ```
      MEMBERSIHKAN FILE FILE SISA YANG TIDAK BERGUNA 

11)	DOWNLOAD MICROSOFT PHOTOS 
     ```powershell
     https://www.microsoft.com/store/productId/9WZDNCRFJBH4
     ```

12)   Jalankan Program Di Terminal
     ```powershell
     iwr -useb https://christitus.com/win | iex
     ```

12) 	RESTART


##LINK SOURCE

     ```powershell
      https://github.com/W4RH4WK/Debloat-Windows-10
      https://drive.google.com/file/d/108hUshW0v-s3yjjWCAK0Zhmu5TZ0Mk_W/view
     ```



