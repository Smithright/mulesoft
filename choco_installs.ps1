#install chrome
choco install googlechrome -y

#install powershell core
choco install powershell-core -y

#install java
choco install temurin11jre -y

 #set java home
 $javaHome = Join-Path $(Get-Item -Path $(Get-Command -Name java).Path).Directory.Parent.FullName 'jdk' [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "Machine")

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



