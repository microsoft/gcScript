$script:dscresource_folder = (Get-Item $PSScriptRoot).Parent
$script:module_folder = (Get-Item $dscresource_folder).Parent

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

    $Phrase = Get-Content $script:module_folder/gcScript.json | ConvertFrom-Json | ForEach-Object {$_.Get} | Invoke-Script

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

    $return = Get-Content $script:module_folder/gcScript.json | ConvertFrom-Json | ForEach-Object {$_.Test} | Invoke-Script

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

    Get-Content $script:module_folder/gcScript.json | ConvertFrom-Json | ForEach-Object {$_.Set} | Invoke-Script
}

function Invoke-Script {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory='true',ValueFromPipeline='true')]
        [string]
        $string
    )

    $string | Out-File $script:module_folder/gcScript.ps1
    & $script:module_folder/gcScript.ps1
    Remove-Item $script:module_folder/gcScript.ps1 -Force
}