#powershell iex(irm sandbox.osdcloud.com)
Set-ExecutionPolicy -ExecutionPolicy Bypass
Install-Script -Name Get-WindowsAutoPilotInfo -Force
Get-WindowsAutoPilotInfo -Online
