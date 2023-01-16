Write-Host  -ForegroundColor Cyan "Starting SeguraOSD's Custom OSDCloud ..."
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Cyan "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#HyperV Tools
Install-Module -Name PSHyperVTools -force

#Make sure I have the latest OSD Content
Write-Host  -ForegroundColor Cyan "Updating the awesome OSD PowerShell Module"
Install-Module OSD -Force

Write-Host ForegroundColor Cyan "Importing HyperV Module"
Import-Module PSHyperVTools -Force

Write-Host  -ForegroundColor Cyan "Importing the sweet OSD PowerShell Module"
Import-Module OSD -Force

#TODO: Spend the time to write a function to do this and put it here
Write-Host  -ForegroundColor Cyan "Ejecting ISO"
Get-VMDvdDrive -VMName "TEST01" | Set-VMDvdDrive -Path $null
#Dismount-DiskImage -ImagePath D:\ISO\zti\OSDCloud.iso
Start-Sleep -Seconds 5

#Start OSDCloud ZTI the RIGHT way
Write-Host  -ForegroundColor Cyan "Start OSDCloud with MY Parameters"
Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 22H2 -OSEdition Pro -OSLanguage en-us -OSLicense Retail -ZTI

#Anything I want  can go right here and I can change it at any time since it is in the Cloud!!!!!
Write-Host  -ForegroundColor Cyan "Starting OSDCloud PostAction ..."
set-location -path C:\ProgramData\OSDCloud\Config\OOBEDeploy
#Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Start-OOBEDeploy -CustomProfile https://raw.githubusercontent.com/roelr1/ZTI/main/OSDeploy.OOBEDeploy.json
#iwr https://git.io/debloat11|iex
Write-Warning "This will take a while"

#Restart from WinPE
Write-Host  -ForegroundColor Cyan "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot
