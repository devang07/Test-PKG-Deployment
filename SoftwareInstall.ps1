Write-Host -ForegroundColor Green "Install Chocolatey to automate basic program installation"
#install Chocolatey and other programs
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	choco install chocolatey-core.extension -y

#Install Chrome
    choco install googlechrome -y --ignore-checksums

#Install Adobe Reader
    choco install adobereader -y

#Install 7-zip
    choco install 7zip -y