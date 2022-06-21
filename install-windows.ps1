# Installer script for Windows Machines

# if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     Write-Error "This script must be run with administrator priviliges"
#     exit $?
# }

$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"

. (Join-Path $CommonFolder 'helpers.ps1')

Deploy-WingetPackage -PackageName 'JanDeDobbeleer.OhMyPosh'
