#install chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#set to auto-update all packages
choco feature enable -n=autoUninstaller
choco feature enable -n=allowGlobalConfirmation
choco feature enable -n=autoUpgrade
choco feature enable -n=useRememberedArgumentsForUpgrades
