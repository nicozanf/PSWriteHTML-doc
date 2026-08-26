New-HTML -Title "Basic Topology Map" -FilePath "Topology.html" -Show {
    New-HTMLTab -Name "Network Map" {
        New-HTMLSection -HeaderText "Local Network Topology" {
            New-HTMLPanel {
                New-HTMLDiagram -Diagram {
                    
                    # Define Nodes
                    New-DiagramNode -Id 1 -Label "Core Router" -Shape "box"
                    New-DiagramNode -Id 2 -Label "Switch-01"   -Shape "box"
                    New-DiagramNode -Id 3 -Label "Server-DB"   -Shape "ellipse"

                    # Define Connections (Links)
                    New-DiagramLink -From 1 -To 2 -Label "10Gbps Trunk"
                    New-DiagramLink -From 2 -To 3 -Label "1Gbps Link"
                } -Height "500px"
            }
        }
    }
}
