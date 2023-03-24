# Define an array of default Java installation locations
$javaInstallationDirs = @(
    "C:\Program Files\Java",
    "C:\Program Files (x86)\Java",
    "C:\Program Files\Eclipse Adoptium"
)

# Find the most recent Java installation directory
$mostRecentJavaDir = ""
$mostRecentJavaVersion = ""
foreach ($javaInstallationDir in $javaInstallationDirs) {
    if (Test-Path $javaInstallationDir) {
        Write-Host "Searching in $javaInstallationDir and all subdirectories"
        $javaDirs = Get-ChildItem -Path $javaInstallationDir -Recurse -Filter "jdk*" -Directory | Sort-Object -Descending -Property Name
        if ($javaDirs.Count -gt 0) {
            $latestJavaDir = $javaDirs[0]
            if ($latestJavaDir.Name -gt $mostRecentJavaVersion) {
                $mostRecentJavaDir = $latestJavaDir.FullName
                $mostRecentJavaVersion = $latestJavaDir.Name
            }
        }
    }
}

if ([string]::IsNullOrWhiteSpace($mostRecentJavaDir)) {
    Write-Warning "No Java installations found in default locations."
} else {
    # Get the current value of the PATH environment variable
    $currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")

    # Add the path to the new Java installation
    $newPath = "$mostRecentJavaDir\bin;$currentPath"

    # Set the updated value of the PATH environment variable
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")

    # Verify that the new Java installation is being used
    java -version
}

