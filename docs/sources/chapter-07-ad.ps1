New-HTML -Title "AD Topology Map" -FilePath "ADTopology.html" -Show {
    New-HTMLTab -Name "AD Map" {
        New-HTMLSection -HeaderText "Local AD Topology" {
            New-HTMLPanel {
                New-HTMLDiagram -Diagram {
                
                # Layout Engine Configuration
                New-DiagramOptionsLayout -HierarchicalEnabled $true -HierarchicalDirection FromUpToDown

                New-DiagramNode -Id 1 -Level 1 -Label "Forest Root Domain" -Shape "box"
                New-DiagramNode -Id 2 -Level 2 -Label "Child Domain A"     -Shape "box"
                New-DiagramNode -Id 3 -Level 2 -Label "Child Domain B"     -Shape "box"

                New-DiagramLink -From 1 -To 2 -ArrowsToEnabled -ArrowsFromEnabled -Label "Two-Way Trust"
                New-DiagramLink -From 1 -To 3 -ArrowsToEnabled -ArrowsFromEnabled -Label "Two-Way Trust"
            } -Height "500px"
            }
        }
    }
}
