New-HTML -Title "Basic Topology Map" -FilePath "Topology.html" -Show {
    New-HTMLTab -Name "Network Map" {
        New-HTMLSection -HeaderText "Local Network Topology" {
            New-HTMLPanel {
                
                  
                New-HTMLDiagram -EnableFiltering -EnableFilteringButton -Diagram {

                    New-DiagramOptionsInteraction -Hover $true

                    # Define Nodes
                    #New-DiagramNode -Id 1 -Label "Core Router"  -IconSolid broadcast-tower
                    
                    New-DiagramNode -Id "GW" -Label "Gateway Router"  -IconBrands hubspot  -IconColor Blue
                    New-DiagramNode -Id "DB" -Label "SQL Cluster"  -Shape database
                    New-DiagramNode -Id "WEB" -Label "Web Server"  -IconSolid server  -IconColor Blue

                    # Define Connections (Edges)
                    New-DiagramEdge -From "GW" -To "WEB" -ArrowsToEnabled
                    New-DiagramEdge -From "WEB" -To "DB" -Label "1Gbps" -ArrowsToEnabled

  
                } -Height "500px"
            }
        }
    }
}
