
#Create Folders
New-Item -ItemType Directory -Force -Path C:\IT\Logs

# Start a transcript session for debug logging
Start-Transcript -Append C:\IT\Logs\PSScriptLog.txt


New-Item -ItemType Directory -Force -Path C:\IT\Scripts

# Download needed scripts
Invoke-WebRequest "https://raw.githubusercontent.com/devang07/Test-PKG-Deployment/main/SoftwareInstall.ps1" -OutFile C:\IT\Scripts\SoftwareInstall.ps1
#Invoke-WebRequest "https://raw.githubusercontent.com/cole-bermudez/Windows-Deployment/main/Windows-Setup.ps1" -OutFile C:\Support\Scripts\WindowsSetup.ps1

# Set admin user PasswordExpires to never
Set-LocalUser -Name "chillit" -PasswordNeverExpires 1

#Create Local User
$UserName = Read-Host "Please set the user's name"
$Password = Read-Host "Please set the password for User" -AsSecureString
New-LocalUser -Name 'admin' -Password 'P@$$3388' -PasswordNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member $UserName


# Disable Privacy Settings after Deployment reboot
#reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1

# Remove autologon after Automate installs
#REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v !cleanup /t REG_SZ /d 'PowerShell -ExecutionPolicy Bypass -File C:\Support\Scripts\cleanup.ps1' /f



#Set Mountain Time Zone
Set-TimeZone -Id "AUS Eastern Standard Time"

# Close debugging log Transcript
Stop-Transcript