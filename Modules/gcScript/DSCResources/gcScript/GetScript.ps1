$InstallationPolicy = Get-PSRepository -Name PSGallery | % InstallationPolicy
"The installation policy for PSGallery is $InstallationPolicy"