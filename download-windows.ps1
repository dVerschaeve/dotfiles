
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"

. (Join-Path $CommonFolder 'variables.ps1') #Import Variables from file

Function Get-DotFiles(){
    [CmdLetBinding()]Param()
    <# 
    
    .Description 
    Function downloads the dotfiles source files and deploys them to a folder 'dotfiles' under the user profile.
    Actions executed:
        1. Create DotFilesFolder
        2. Downloads the dotfiles repository as ZIP file into the DotFilesFolder
        3. Extract the ZIP file
        4. Copies any source file directly into the DotFilesFolder
    #>
    
    If (Test-Path $DotfilesFolder) {
        Write-Verbose ("Purging old dotfiles")
        Remove-Item -Path $DotfilesFolder -Recurse -Force;
    }
    New-Item $DotfilesFolder -ItemType directory | Out-Null
    Write-Verbose ("$DotFilesFolder Created")

    Write-Verbose("Download Repo '$GITRepo' as ZIP")
    Try {
        Invoke-WebRequest $GITRepo -OutFile $ArchiveFile
    }
    Catch [System.Net.WebException] {
        Write-Verbose $_.Exception.Message
        Throw "Unable to fetch source files"
    }

    Write-Verbose("Extracting sources files")
    Expand-Archive -LiteralPath $ArchiveFile -DestinationPath $DotfilesFolder

    Write-Verbose("Cleanup downloaded ZIP file")
    Remove-Item -Path $ArchiveFile -Confirm:$false -Force

    $ExtractedFolder = Get-ChildItem $DotfilesFolder -Directory -Filter 'dotfiles*'
    Write-Verbose("Extracted Folder: {0}" -f $ExtractedFolder.FullName)
    Get-ChildItem -Path $ExtractedFolder.FullName | Move-Item -Destination $DotfilesFolder 

    Remove-Item -Path $ExtractedFolder.FullName -Recurse -Confirm:$False -Force
    Get-ChildItem $DotfilesFolder

    Invoke-Expression (Join-Path -Path $DotfilesFolder -ChildPath "install-windows.ps1");
}

Write-Host "Downloading and deploying DotFiles from repository"  -ForegroundColor Green
Write-Host ("DotFiles folder: {0}" -f $DotfilesFolder) -ForegroundColor Green
If($DebugMode){
    Get-DotFiles -Verbose
} Else {
    Get-DotFiles
}