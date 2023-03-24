#install chrome
choco install googlechrome -y

    #set chrome as default browser
    
        # Get the path to the Chrome executable
        $chromePath = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').DirectoryName + '\chrome.exe'
        [Environment]::SetEnvironmentVariable("BROWSER", $chromePath, "Machine")

        # Set Chrome as the default browser for HTTP URLs
        $regPath = 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default browser for HTTPS URLs
        $regPath = 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default program for .htm files
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default program for .html files
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default program for .shtml files
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.shtml\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default program for .xht files
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

        # Set Chrome as the default program for .xhtml files
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml\UserChoice'
        Set-ItemProperty -Path $regPath -Name ProgId -Value 'ChromeHTML'

#install powershell core
choco install powershell-core -y

#install java
choco install temurin11jre -y

 #set java home
 $javaHome = Join-Path (Split-Path (Get-Command java).Source) "jdk"
 [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "Machine")
 

#install .net
choco install dotnetcore-sdk -y

#check list of installed packages
choco list --local-only

# Get list of installed Chocolatey packages
$packages = Get-Package

# Iterate through each package and create desktop shortcut if one doesn't already exist
foreach ($package in $packages) {
    $installDir = $package.InstallLocation
    $packageName = $package.Name

    # Try to retrieve the path of the first .exe file in the package directory
    try {
        $exePath = Get-ChildItem $installDir -Filter *.exe | Select-Object -First 1 -ErrorAction Stop
    }
    catch {
        Write-Warning "Could not retrieve path for $packageName: $_"
        continue
    }

    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $shortcutPath = Join-Path $desktopPath "$packageName.lnk"

    if (-not (Test-Path $shortcutPath)) {
        $wshShell = New-Object -ComObject WScript.Shell
        $shortcut = $wshShell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $exePath.FullName
        $shortcut.Save()
        Write-Output "Desktop shortcut created for $packageName"
    } else {
        Write-Output "Desktop shortcut for $packageName already exists"
    }
}



