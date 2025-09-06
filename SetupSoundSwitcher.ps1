<#
.SYNOPSIS
    Simple Sound Device Switcher - Creates desktop shortcuts for switching Windows audio playback devices

.DESCRIPTION
    This script creates desktop shortcuts for each active Windows playback audio device.
    Clicking a shortcut switches the default audio device.

.EXAMPLE
    .\SetupSoundSwitcher.ps1
    Creates shortcuts on desktop for all active playback devices.
#>

param(
    [string]$ShortcutLocation = [Environment]::GetFolderPath("Desktop")
)

#Requires -RunAsAdministrator

# Get all active playback devices
$devices = Get-AudioDevice -List | Where-Object {
    $_.Type -eq "Playback" -and $_.DeviceState -ne "Disabled"
}

if ($devices.Count -eq 0) {
    Write-Host "No active playback devices found."
    exit 1
}

Write-Host "Found $($devices.Count) active playback device(s):"
$devices | ForEach-Object {
    Write-Host "  - $($_.Name)"
}

# Create shortcuts for each device
foreach ($device in $devices) {
    $safeName = $device.Name -replace '[^\w\s-]', '' -replace '\s+', '_'
    $shortcutPath = Join-Path $ShortcutLocation "$safeName.lnk"

    Write-Host "Creating shortcut for: $($device.Name)"

    try {
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($shortcutPath)
        $Shortcut.TargetPath = "powershell.exe"
        $Shortcut.Arguments = "-Command `"Set-AudioDevice -ID '$($device.ID)'`""
        $Shortcut.WorkingDirectory = $ShortcutLocation
        $Shortcut.IconLocation = "powershell.exe,0"
        $Shortcut.Description = "Switch to $($device.Name)"
        $Shortcut.Save()

        Write-Host "Created shortcut: $shortcutPath"
    }
    catch {
        Write-Host "Failed to create shortcut for $($device.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nSetup complete! Shortcuts created in: $ShortcutLocation"