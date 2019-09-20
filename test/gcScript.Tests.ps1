$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

$script:moduleName = 'gcScript'

Describe "gcScript Tests" {

    BeforeAll {
        $resourceModulePath = Join-Path -Path (Split-Path $PSScriptRoot -Parent) -ChildPath "Modules\gcScript\DscResources\gcScript\gcScript.psm1"
        Import-Module -Name $resourceModulePath -Force
    }

    InModuleScope 'gcScript' {

        Context 'module manifest' {

            It 'Has a PowerShell module manifest that meets functional requirements' {
                Test-ModuleManifest -Path .\Modules\gcScript\gcScript.psd1 | Should Not BeNullOrEmpty
                $? | Should Be $true
            }
        }

        Context "gcScript\Set-TargetResource" {

            It 'Should always throw' {
                { Set-TargetResource } | Should Throw
            }
        }

        Context 'when the system is in the desired state' {

            Context "gcScript\Get-TargetResource" {
                $get = Get-TargetResource

                It 'Should return an empty array for the property Reasons' {
                    $get.Reasons | Should -Be $null
                }
            }

            Context "gcScript\Test-TargetResource" {
                $test = Test-TargetResource

                It 'Should pass Test' {
                    $test | Should -BeTrue
                }
            }
        }

        Context 'when the system is not in the desired state' {

            Context "gcScript\Get-TargetResource" {
                $get = Get-TargetResource

                It 'Should return a hashtable for the property Reasons' {
                    $get.Reasons | Should -BeOfType 'Hashtable'
                }

                It 'Should have at least one reasons code' {
                    $get.reasons[0] | ForEach-Object Code | Should -BeOfType 'String'
                    $get.reasons[0] | ForEach-Object Code | Should -Match "$script:moduleName:$script:moduleName:"
                }

                It 'Should have at least one reasons phrase' {
                    $get.reasons | ForEach-Object Phrase | Should -BeOfType 'String'
                }
            }

            Context "gcScript\Test-TargetResource" {
                $test = Test-TargetResource

                It 'Should fail Test' {
                    $test | Should -BeFalse
                }

            }
        }
    }
}

