New-HTML -Show {
    New-HTMLSection -HeaderText "System Resource Utilization" {
        
        # Left Column (Panel 1)
        New-HTMLPanel {
            New-HTMLText -Text "CPU Load History Chart"
        }

        # Middle Column (Panel 2)
        New-HTMLPanel {
            New-HTMLText -Text "RAM Consumption Chart"
        }

        # Right Column (Panel 3)
        New-HTMLPanel {
            New-HTMLText -Text "Storage Allocation Summary"
        }
    }
}