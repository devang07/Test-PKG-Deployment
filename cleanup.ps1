Start-Transcript -Append C:\Support\Logs\PostDeploymentCleanupLog.txt

# Sleep to let registry populate
#Start-Sleep -s 10

# Disable autoLogon
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f

# Run WindowsSetup2_0-WIP
iex -Command "C:\Support\Scripts\Windows-Setup.ps1"

# Removes install directories except logs
Remove-Item -Path C:\\Support\\Scripts -Recurse -Verbose

#Start-Sleep -s 5

Stop-Transcript
