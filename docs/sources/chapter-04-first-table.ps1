$Services = Get-Service | Select-Object Name, DisplayName, Status, StartType | Select-Object -First 15

New-HTML -Title "Service Overview" -FilePath "Services.html" -Show {
    New-HTMLTab -Name "Services" {
        New-HTMLSection -HeaderText "Local System Services" {
            New-HTMLPanel {
                New-HTMLTable -DataTable $Services
            }
        }
    }
}