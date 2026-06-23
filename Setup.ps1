# Setup script to install Launcher.ps1 to user startup (running hidden)

$targetScript = Join-Path $PSScriptRoot "Launcher.ps1"
$startupFolder = [System.Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupFolder "NetpolLauncher.lnk"

# Ensure Launcher.ps1 exists
if (-not (Test-Path $targetScript)) {
    Write-Error "Launcher.ps1 not found in the current directory: $PSScriptRoot"
    exit 1
}

# Create shortcut in the Startup folder using COM WScript.Shell
try {
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$targetScript`""
    $shortcut.WorkingDirectory = $PSScriptRoot
    $shortcut.Description = "Launches Netpol in the background at startup"
    $shortcut.WindowStyle = 7 # 7 corresponds to Minimized/Hidden
    $shortcut.Save()
    Write-Host "Successfully installed Launcher shortcut to startup folder:"
    Write-Host $shortcutPath
}
catch {
    Write-Error "Failed to create startup shortcut: $_"
    exit 1
}
