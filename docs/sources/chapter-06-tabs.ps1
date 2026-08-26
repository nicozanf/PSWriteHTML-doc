New-HTML -Title "Infrastructure Status" -FilePath "MultiTab.html" -Show {
    
    # Tab 1: Server Health with FontAwesome Icon
    New-HTMLTab -Name "Servers" -IconSolid "server" {
        New-HTMLSection -HeaderText "Active Nodes" {
            New-HTMLPanel {
                New-HTMLText -Text "Server details go here."
            }
        }
    }

    # Tab 2: Security Alerts with a Red Warning Badge
    New-HTMLTab -Name "Alerts" -IconSolid "exclamation-triangle" -IconColor "Red" {
        New-HTMLSection -HeaderText "Unresolved Incident Reports" {
            New-HTMLPanel {
                New-HTMLText -Text "Security incident details go here."
            }
        }
    }
}
