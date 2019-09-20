
function Get-TargetResource {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter()]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance = 'Yes'
    )

    $Phrase = & $PSScriptRoot\GetScript.ps1

    $reasons = @()
        $reasons += @{
            Code   = 'gcScript:gcScript:ScriptOutput'
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
        [Parameter()]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance = 'Yes'
    )

    $return = & $PSScriptRoot\TestScript.ps1

    return $return
}

function Set-TargetResource {
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance = 'Yes'
    )

    throw 'Set functionality is not supported in this version of the DSC resource.'
}
