$SystemNames = Get-Content -Path "C:\Temp\Clients.txt"

ForEach ($System in $SystemNames) {
    Invoke-Command -ComputerName $System -ScriptBlock {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        #Load IIS Powershell
        If (-NOT (Get-Module -Name WebAdministration -ListAvailable)) {
            Install-Module -Name WebAdministration -AllowClobber -Force -SkipPublisherCheck -Scope AllUsers | Out-Default
        }

        Import-Module WebAdministration

        $userName = "domain\username"
        $password = "Password"
        $appPoolName = "DefaultAppPool"

        Set-ItemProperty IIS:\AppPools\$appPoolName -name processModel.identityType -Value SpecificUser
        Set-ItemProperty IIS:\AppPools\$appPoolName -name processModel.userName -Value $userName
        Set-ItemProperty IIS:\AppPools\$appPoolName -name processModel.password -Value $password

    }
}

IIS RESTART /FORCE 