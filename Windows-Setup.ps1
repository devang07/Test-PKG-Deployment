
# Create a log file for debugging
Start-Transcript -Append C:\Support\Logs\WindowsSetupLog.txt

#initiates the variables required for the script
$diskProps = (Get-PhysicalDisk | where size -gt 100gb)
$cortanaPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
$HighPerf = powercfg -l | %{if($_.contains("High performance")) {$_.split()[3]}}
$confirmUac = 'n'
$confirmInfo = 'n'
$confirmPower = 'n'
$confirmDev = 'n'
$avCheck = $false
$installCheck = 'n'
$officeCheck = $false

#Set F8 to boot to Safe Mode
#Write-Host -ForegroundColor Green "Setting boot menu to legacy"
#bcdedit /set "{current}" bootmenupolicy legacy

#Set Percentage for System Protection
#Write-Host -ForegroundColor Green "Setting size for system restore"
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=5%

#Configure over provisioning for SSD
#Write-Host -ForegroundColor Green "Configure Over Provisioning via TRIM"
#fsutil behavior set DisableDeleteNotify 0


# Enable system restore on C:\

#Write-Host -ForegroundColor Green "Enabling system restore..."
Enable-ComputerRestore -Drive "$env:SystemDrive"

#Force Restore point to not skip
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /V "SystemRestorePointCreationFrequency" /T REG_DWORD /D 0 /F

#Disable sleep timers and create a restore point just in case
Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

#Set Power Options
Write-Host -ForegroundColor Green "Set Power options and Time Zone"
powercfg.exe -change -monitor-timeout-ac 0
powercfg.exe -change -monitor-timeout-dc 0
powercfg.exe -change -disk-timeout-ac 0
powercfg.exe -change -disk-timeout-dc 0
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -standby-timeout-dc 0
powercfg.exe -change -hibernate-timeout-ac 0
powercfg.exe -change -hibernate-timeout-dc 0


#Set Mountain Time Zone
Set-TimeZone -Id "AUS Eastern Standard Time"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	choco install chocolatey-core.extension -y

#Install Java
    #choco install jre8 -y

#Install Firefox
    #choco install firefox -y

#Install Chrome
    #choco install googlechrome -y --ignore-checksums

#Install Adobe Reader
    #choco install adobereader -y

#Install 7-zip
    choco install 7zip -y

#Close debugging log Transcript
Stop-Transcript

#Write-Host -ForegroundColor Green "Windows Setup complete."
#Sleep to read completion
#Start-Sleep -s 5
#Write-Host -ForegroundColor Green "The Computer will restart in 10 seconds"
#Start-Sleep -s 10
Restart-Computer