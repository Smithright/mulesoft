#Download most recent
Invoke-WebRequest -Uri "https://api.adoptium.net/v3/assets/latest/11/ga/windows/x64/jdk/hotspot/normal/adoptium-jdk-11-hotspot-x64-windows.zip" -OutFile "$([Environment]::GetFolderPath('UserDownloads'))\jdk.zip"
