# REM add a user for the muleBot, prompt for password, display for confirmation
net user muleBot [yourMuleBotPassword] /add

# REM Add the user to the Administrators group
net localgroup Administrators %username% /add

# REM Add the User to the Remote access group
net localgroup "Remote Desktop Users" %username% /add
