<#
.SYNOPSIS
  Define file to be in place when IvantiAM is completed.
.DESCRIPTION
  Define file to be in place when IvantiAM is completed.
.NOTES
  Version:        1.0
  Author:         Marc Westerduin
  Creation Date:  20-10-2023
.EXAMPLE
  na
#>
#># Set variables$Vendor = "Ivanti"$Product = "AM"$PackageName = "Ivanti_Automation_Agent+(x64)_10.20.0.0"$Version = "10.20.0.0"$InstallerType = "msi"$Source = "$PackageName" + "." + "$InstallerType"$LogPS = "${env:SystemRoot}" + "\Temp\$Vendor $Product $Version PS Wrapper.log"$LogApp = "${env:SystemRoot}" + "\Temp\$PackageName.log"$Destination = "${env:ChocoRepository}" + "\$Vendor\$Product\$Version\$packageName.$installerType"#$UnattendedArgs = "/i $PackageName.$InstallerType /qn /liewa $LogApp"#$UnattendedArgs = "/qn /liewa $LogApp"$UnattendedArgs = "/i $PackageName.$InstallerType /qn"$TargetDir = "C:\Temp"$LogFileName = $myinvocation.MyCommand.Name + ".log"$LogFile = Join-Path -Path $TargetDir\Logs -ChildPath $LogFileName$wantfile = "c:\temp\IvantiAM_complete.txt"$msifile = "c:\temp\Ivanti_Automation_Agent+(x64)_10.20.0.0.msi"Write-Host "Check for directories and create them if necessary"if(-not (Test-Path -Path $TargetDir)){ New-Item -Path $TargetDir -ItemType Directory }if(-not (Test-Path -Path $TargetDir\Logs)){ New-Item -Path $TargetDir\Logs -ItemType Directory }#Install IvantiAM$StartTime = Get-DateWrite-Verbose "Starting Installation of $Vendor $Product $Version" -Verbose#(Start-Process msiexec "$PackageName.$InstallerType" $UnattendedArgs -Wait -Passthru).ExitCodec:cd \temp(Start-Process msiexec.exe $UnattendedArgs -Wait -Passthru).ExitCodeWhile (!(Test-Path $wantfile -ErrorAction SilentlyContinue)){  Write-Host "IvantiAM still running..."}$End = Get-Date#Write-Host "IvantiAM is Finished"Write-Host "Continueing Packer..."#Restart-ComputerStop-Transcript