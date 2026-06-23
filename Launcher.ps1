# Self-relaunch in the background to hide the parent PowerShell window
if ($args[0] -ne 'hidden') {
    Start-Process powershell -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$PSCommandPath`" hidden" -WindowStyle Hidden
    exit
}

# Updates the scripts with the last version from git
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
Start-Process git -ArgumentList "pull" -WorkingDirectory "$PSScriptRoot" -WindowStyle Hidden -Wait

# Install requirements.txt with "pip install -r requirements.txt"
Start-Process python -ArgumentList "-m pip install -r requirements.txt" -WorkingDirectory "$PSScriptRoot" -WindowStyle Hidden -Wait

# Run the python script "main.py" from current directory in the background
Start-Process python -ArgumentList "main.py" -WorkingDirectory "$PSScriptRoot" -WindowStyle Hidden

