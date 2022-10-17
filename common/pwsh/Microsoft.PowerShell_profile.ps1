$ProgressPreference = "SilentlyContinue"

$env:AZ_ENABLED = $true # Depricated Setting
$env:DOTFILES = Join-path $Home ".dotfiles"
$ENV:OHMYPWSH = "{0}.{1}" -f $PSVersionTable.PSVersion.Major, $PSVersionTable.PSVersion.Minor


Import-Module 'Terminal-Icons' -ErrorAction SilentlyContinue

If(Test-Path $Env:DOTFILES){
	$TerminalPrompt = Join-path $Env:DOTFILES "\common\ohmyposh\terminalprompt.omp.json"
	oh-my-posh --init --shell pwsh --config $TerminalPrompt | Invoke-Expression
	$env:POSH_AZURE_ENABLED = $true
}

# DOT source workstation related files
$CustomFolder = Join-Path (Split-Path $profile) "Custom"
If(Test-Path $CustomFolder){
	$POSHFiles = Get-ChildItem -Path $CustomFolder -Filter *.ps1
	ForEach($POSHFile in $POSHFiles){
		. $POSHFile.FullName
	}
}

Clear-Host