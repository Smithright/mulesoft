REM add a user for the muleBot, prompt for password, display for confirmation
@echo off
set "username=muleBot"
set /p "username=Enter username [%username%]: "

powershell -Command "$password = Read-Host 'Enter password' -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)" > password.txt

set /p password=<password.txt

net user %username% %password% /add

echo User: %username%
echo Password: %password%

del password.txt


REM Add the user to the Administrators group
net localgroup Administrators %username% /add

REM Add the User to the Remote access group
net localgroup "Remote Desktop Users" %username% /add
