$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

$script:moduleName = 'gcJSON'

Describe "gcJSON Tests" {

    BeforeAll {
        $resourceModulePath = Join-Path -Path (Split-Path $PSScriptRoot -Parent) -ChildPath "Modules\gcJSON\DscResources\gcJSON\gcJSON.psm1"
        Import-Module -Name $resourceModulePath -Force
    }

    InModuleScope 'gcJSON' {

        Context 'module manifest' {

            It 'Has a PowerShell module manifest that meets functional requirements' {
                Test-ModuleManifest -Path .\Modules\gcJSON\gcJSON.psd1 | Should Not BeNullOrEmpty
                $? | Should Be $true
            }
        }

        Context "gcJSON\Set-TargetResource" {

            It 'Should always throw' {
                { Set-TargetResource } | Should Throw
            }
        }

        Context 'when the system is in the desired state' {

            Context "gcJSON\Get-TargetResource" {
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

            Context "gcJSON\Test-TargetResource" {
                Mock Invoke-Script { $true }
                $test = Test-TargetResource

                It 'Should pass Test' {
                    $test | Should -BeTrue
                }
            }
        }

        Context 'when the system is not in the desired state' {

            Context "gcJSON\Get-TargetResource" {
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

            Context "gcJSON\Test-TargetResource" {
                Mock Invoke-Script { $false }
                $test = Test-TargetResource

                It 'Should fail Test' {
                    $test | Should -BeFalse
                }

            }
        }
    }
}

