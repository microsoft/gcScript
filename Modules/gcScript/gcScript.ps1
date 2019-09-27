powershell.exe -command {(Get-PSRepository -Name PSGallery | % InstallationPolicy) -eq 'Untrusted'}
