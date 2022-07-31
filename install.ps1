
# Create working directory
New-Item -ItemType Directory -Force -Path C:\Support
New-Item -ItemType Directory -Force -Path C:\Support\Scripts
New-Item -ItemType Directory -Force -Path C:\Support\Logs

# Start a transcript session for debug logging
Start-Transcript -Append C:\Support\Logs\PSScriptLog.txt

# Download needed scripts
Invoke-WebRequest "https://raw.githubusercontent.com/devang07/Test-PKG-Deployment/main/cleanup.ps1" -OutFile C:\Support\Scripts\cleanup.ps1
Invoke-WebRequest "https://raw.githubusercontent.com/devang07/Test-PKG-Deployment/main/Windows-Setup.ps1" -OutFile C:\Support\Scripts\Windows-Setup.ps1

# Set admin user PasswordExpires to never
Set-LocalUser -Name "admin" -PasswordNeverExpires 1
Set-LocalUser -Name "chillit" -PasswordNeverExpires 1

# Disable Privacy Settings after Deployment reboot
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1

# Enable Autologon after deployment reboot
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d . /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d admin /f
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d 'admin' /f

# Remove autologon after Automate installs
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v !cleanup /t REG_SZ /d 'PowerShell -ExecutionPolicy Bypass -File C:\Support\Scripts\cleanup.ps1' /f

# Close debugging log Transcript
Stop-Transcript
