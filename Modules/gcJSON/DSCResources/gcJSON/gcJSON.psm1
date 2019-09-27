function Get-TargetResource {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance
    )

    $Phrase = Get-Content "$psscriptroot\gcJSON.json" | ConvertFrom-Json | ForEach-Object {$_.Get} | Invoke-Script

    $reasons = @()
        $reasons += @{
            Code   = 'gcJSON:gcJSON:ScriptOutput'
            Phrase = $Phrase
        }

    $return = @{
        reasons = $reasons
    }

    return $return
}

function Test-TargetResource {
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance
    )

    $return = Get-Content "$psscriptroot\gcJSON.json" | ConvertFrom-Json | ForEach-Object {$_.Test} | Invoke-Script

    return $return
}

function Set-TargetResource {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance
    )

    Get-Content "$psscriptroot\gcJSON.json" | ConvertFrom-Json | ForEach-Object {$_.Set} | Invoke-Script
}

function Invoke-Script {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string]
        $string
    )

    $string | Out-File "$psscriptroot\gcJSON.ps1"
    & "$psscriptroot\gcJSON.ps1"
    Remove-Item "$psscriptroot\gcJSON.ps1" -Force
}
