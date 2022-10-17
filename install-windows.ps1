# Installer script for Windows Machines

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run with administrator priviliges"
    exit $?
}

$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"
$WindowsFolder = Join-Path $ScriptFolder "windows"

. (Join-Path $CommonFolder 'pwsh\variables.ps1') #Import Variables from file
. (Join-Path $CommonFolder 'pwsh\hlpWinget.ps1')
. (Join-Path $WindowsFolder 'Fonts\hlpFonts.ps1')
. (Join-Path $WindowsFolder 'Terminal\Terminal.ps1')

Deploy-WingetPackage -PackageName 'Microsoft.WindowsTerminal'
Deploy-WingetPackage -PackageName 'Microsoft.VisualStudioCode'
Deploy-WingetPackage -PackageName 'Microsoft.AzureCLI'
Deploy-WingetPackage -PackageName 'Microsoft.Bicep'
Deploy-WingetPackage -PackageName 'Microsoft.PowerShell'
Deploy-WingetPackage -PackageName 'Microsoft.PowerToys'
Deploy-WingetPackage -PackageName 'Microsoft.AzureStorageExplorer'
Deploy-WingetPackage -PackageName 'JanDeDobbeleer.OhMyPosh'
Deploy-WingetPackage -PackageName 'Git.Git'
Deploy-WingetPackage -PackageName 'PuTTY.PuTTY'
Deploy-WingetPackage -PackageName 'Notepad++.Notepad++'
Deploy-WingetPackage -PackageName 'Obsidian.Obsidian'


Get-NerdFont -FontName "CascadiaCode"

# Deploy PowerShell Profile files
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")

$PowerShellFolders = @("PowerShell", "WindowsPowerShell")
ForEach($PowerShellFolder in $PowerShellFolders){
    $TargetFolder = Join-Path ($MyDocuments) $PowerShellFolder
    Write-Host "Copy PowerShell profile to" $TargetFolder  -ForegroundColor Green
    If(-Not (Test-Path $TargetFolder)){
        New-Item -Path $TargetFolder -ItemType Directory -Force | Out-Null
    } 

    $VSCodeFile = Join-Path $TargetFolder "Microsoft.VSCode_profile.ps1"
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerSHell_Profile.ps1') -Destination $TargetFolder -Force -Confirm:$false
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerSHell_Profile.ps1') -Destination $VSCodeFile -Force -Confirm:$false
}

$TerminalBackgroundImage = Join-path $DotfilesFolder '\Windows\Terminal\terminal_background.jpg'
Set-WindowsTerminal -TerminalBackgroundImage $TerminalBackgroundImage

# Deploy Standard Modules
Import-Module (join-path $pwshModulesFolder 'vdmodules')
Sync-vdPsModules -JSONFile (Join-Path $DotfilesFolder "\common\pwsh\pwshModules.json")