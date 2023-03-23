<#
    .SYNOPSIS
        Run this script in your Windows 10 VM to optimize configuration for 
        MuleSoft RPA tools, including: RPA Builder, RPA Recorder, RPA Bot

    .DESCRIPTION
        This script automates the process of configuring a Windows 10 VirtualBox
        to optimize it for MuleSoft RPA usage. It modifies various settings, such as
        visual effects, system performance, and other environment configurations.

    .NOTES
        File Name      : ConfigureWin10VirtualBox.ps1
        Author         : smith.ryan@mulesoft.com
        Version        : 1.0
        Prerequisites  : PowerShell Core, Administrative privileges, Windows 10 Pro
        
    .LINK
        https://docs.mulesoft.com/rpa-home/hardware-software-requirements

    .EXAMPLE
        .\ConfigureWin10VirtualBox.ps1
        Description: Runs the script to configure the Windows 10 VirtualBox.
#>


# Disable screen saver
Write-Host "Disabling screen saver..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value 0

# Turn off all power option properties
Write-Host "Turning off all power option properties..."
powercfg.exe /Change monitor-timeout-ac 0
powercfg.exe /Change monitor-timeout-dc 0
powercfg.exe /Change disk-timeout-ac 0
powercfg.exe /Change disk-timeout-dc 0
powercfg.exe /Change standby-timeout-ac 0
powercfg.exe /Change standby-timeout-dc 0
powercfg.exe /Change hibernate-timeout-ac 0
powercfg.exe /Change hibernate-timeout-dc 0

# Disable automatic Windows updates
Write-Host "Disabling automatic Windows updates..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1

# Disable ClearType
Write-Host "Disabling ClearType..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value 0

# Disable menu drop-shadow effects
Write-Host "Disabling menu drop-shadow effects..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Value 0

# Set desktop scaling to 100%
Write-Host "Setting desktop scaling to 100%..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Value 96

# Set Windows fonts to default
Write-Host "Restoring default Windows fonts..."
$DefaultFontsFolder = "$env:windir\Fonts"
$FontBackupFolder = "C:\WindowsFontBackup"
If (!(Test-Path -Path $FontBackupFolder)) {
    New-Item -Path $FontBackupFolder -ItemType Directory
}
Copy-Item -Path "$DefaultFontsFolder\*" -Destination $FontBackupFolder -Recurse -Force

Write-Host "Configuration complete. You may need to restart your computer for changes to take effect."

# Set visual effects to "Adjust for best performance"
Write-Host "Setting visual effects to 'Adjust for best performance'..."
$performanceSettings = @{
    "UserPreferencesMask" = "0x0000000110"; # Adjust for best performance
}

foreach ($setting in $performanceSettings.GetEnumerator()) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name $setting.Name -Value $setting.Value
}

Write-Host "Visual effects adjusted for best performance. You may need to restart your computer for changes to take effect."

