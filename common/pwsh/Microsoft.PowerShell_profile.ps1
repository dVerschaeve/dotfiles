$ProgressPreference = "SilentlyContinue"

$ENV:AZ_ENABLED = $true # Depricated Setting
$ENV:DOTFILES = Join-path $Home ".dotfiles"
$ENV:OHMYPWSH = "{0}.{1}" -f $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor

$CustomModules = Join-Path $ENV:DOTFILES "common\pwsh\modules"
Import-Module (Join-Path $CustomModules "vdhelpers")
Import-Module (Join-Path $CustomModules "vdmodules")


Import-Module 'Terminal-Icons' -ErrorAction SilentlyContinue

If(Test-Path $Env:DOTFILES){
	$TerminalPrompt = Join-path $Env:DOTFILES "\common\ohmyposh\terminalprompt.omp.json"
	oh-my-posh --init --shell pwsh --config $TerminalPrompt | Invoke-Expression
	$ENV:POSH_AZURE_ENABLED = $true
}

# DOT source workstation related files
$CustomFolder = Join-Path (Split-Path $profile) "Custom"
If(Test-Path $CustomFolder){
	$POSHFiles = Get-ChildItem -Path $CustomFolder -Filter *.ps1
	ForEach($POSHFile in $POSHFiles){
		. $POSHFile.FullName
	}
}

Function Update-DotFiles(){
	If($Null -eq $IsWindows){
		# Running under Windows PowerShell
		$UpdateScript = Join-Path $env:DOTFILES "download-windows.ps1"
		& $UpdateScript
	} Else {
		# Running under PowerShell 7
		If($IsWindows){
			$UpdateScript = Join-Path $env:DOTFILES "download-windows.ps1"
			& $UpdateScript
		}
	}
}

Clear-Host