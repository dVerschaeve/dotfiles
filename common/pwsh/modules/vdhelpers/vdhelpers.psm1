function New-vdLogMessage(){
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)]$Message,
        [Parameter(Mandatory=$False)][ValidateSet("INFO","DEBUG","ERROR","TITLE")][String]$Level = "INFO",
        [Parameter(Mandatory=$False)][Int]$Ident = 0
    )

    
    $Time = Get-Date
    [String]$Identation = ""
    for($i = 0; $i -lt $Ident; $i++){
        $Identation = " {0}" -f $Identation
    }
    
    $LogMessage = "[{0}] - {1} {2} - {3}" -f $Time, $Level, $Identation, $Message

    Switch($Level){
        "TITLE" {
            $TitleLength = 104
            $LogMessage = "#"
            for($i = 0; $i -lt (([Math]::Max(0, $TitleLength / 2) - [Math]::Max(0, $Message.Length / 2))) - 4; $i++)
            {
                $LogMessage = $LogMessage + "#"
            }
        
            $LogMessage = $LogMessage + " " + $Message + " "
        
            For($i = 0; $i -lt ($TitleLength - ((([Math]::Max(0, $TitleLength / 2) - [Math]::Max(0, $Message.Length / 2))) - 2 + $Message.Length)) - 2; $i++)
            {
                $LogMessage = $LogMessage + "#"
            }
            Write-Host $LogMessage -ForegroundColor Green
        }
        "ERROR"{ Write-Host $LogMessage -ForegroundColor Red }
        "DEBUG"{ Write-Host $LogMessage -ForegroundColor Yellow }
        Default {Write-Host $LogMessage  }
    }
}