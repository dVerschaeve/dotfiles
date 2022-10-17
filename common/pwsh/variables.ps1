$DebugMode = $True
$GITRepo = 'https://github.com/dVerschaeve/dotfiles/archive/refs/heads/main.zip'
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$pwshModulesFolder = Join-Path $DotFilesFolder "common\pws\modules"

$ArchiveFile = Join-Path $DotfilesFolder -ChildPath "sourceFiles.zip" # Used to download dotfiles source files from GitHub