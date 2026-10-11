$Processes = Get-Process |
    Select-Object ProcessName, Id, CPU, WorkingSet64 |
    Select-Object -First 15

New-HTML -Title "Process Overview" -FilePath "Processes.html" -Show {
    New-HTMLTab -Name "Processes" {
        New-HTMLSection -HeaderText "Local System Processes" {
            New-HTMLPanel {
                New-HTMLTable -DataTable $Processes
            }
        }
    }
}