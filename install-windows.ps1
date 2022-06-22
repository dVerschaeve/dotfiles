# Installer script for Windows Machines

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run with administrator priviliges"
    exit $?
}

$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"

. (Join-Path $CommonFolder 'helpers.ps1')

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
