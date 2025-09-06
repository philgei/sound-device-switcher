# Sound Device Switcher

A simple PowerShell script that creates desktop shortcuts for switching between Windows audio playback devices.

## Quick Start

1. **Run the Setup Script as Administrator**:

   ```powershell
   .\SetupSoundSwitcher.ps1
   ```

2. **Check Your Desktop**: Shortcuts will be created for each active playback device.

## Requirements

- Windows 10/11
- PowerShell 5.1 or higher
- Administrator privileges
- AudioDeviceCmdlets module (will be installed automatically if needed)

## How It Works

The script:

1. Finds all active playback audio devices
2. Creates desktop shortcuts for each device
3. Each shortcut switches to that specific audio device when clicked

**Tip:** You can rename the shortcuts to your liking after they're created - just right-click and select "Rename".

## Troubleshooting

- Make sure to run as Administrator
- Ensure AudioDeviceCmdlets module can be installed
- Check that your audio devices are enabled in Windows Sound settings

## License

MIT License
