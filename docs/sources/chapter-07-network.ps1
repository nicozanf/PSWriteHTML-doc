   New-HTML -Title "Data Center Network Diagram" -FilePath "$env:USERPROFILE\Desktop\NetworkMap.html" -Show {
       New-HTMLTab -Name "Topology" -IconSolid "network-wired" {
           New-HTMLSection -HeaderText "Production Infrastructure Mesh" {
               New-HTMLPanel {
                   New-HTMLDiagram -Diagram {

                       # 1. External & Perimeter Layer
                       New-DiagramNode -Id "INET" -Label "Internet / WAN" -Shape "circle" -ColorBackground "#0288D1"
                       New-DiagramNode -Id "FW01" -Label "Perimeter Firewall" -Shape "box" -ColorBackground "#D32F2F"

                       # 2. Distribution Layer
                       New-DiagramNode -Id "SW01" -Label "Core Switch 01" -Shape "box" -ColorBackground "#1976D2"
                       New-DiagramNode -Id "SW02" -Label "Core Switch 02 (HA)" -Shape "box" -ColorBackground "#1976D2"

                       # 3. Workload Layer
                       New-DiagramNode -Id "APP"  -Label "App Tier Cluster" -Shape "ellipse" -ColorBackground "#388E3C"
                       New-DiagramNode -Id "DB"   -Label "SQL Availability Group" -Shape "database" -ColorBackground "#F57C00"

                       # 4. Define Interconnects
                       New-DiagramLink -From "INET" -To "FW01" -ArrowsToEnabled -Label "Inbound Traffic"
                       New-DiagramLink -From "FW01" -To "SW01" -ArrowsToEnabled -Color "#D32F2F"
                       New-DiagramLink -From "FW01" -To "SW02" -ArrowsToEnabled -Color "#D32F2F" -Dashes $true
                       
                       # Core Switch Trunking
                       New-DiagramLink -From "SW01" -To "SW02" -ArrowsToEnabled -ArrowsFromEnabled -Label "LACP Trunk" -Color "#1976D2"
                       
                       # App & DB Connects
                       New-DiagramLink -From "SW01" -To "APP"  -ArrowsToEnabled
                       New-DiagramLink -From "SW02" -To "APP"  -ArrowsToEnabled
                       New-DiagramLink -From "APP"  -To "DB"   -ArrowsToEnabled -Label "Port 1433"
                   } -Height "650px"
               }
           }
       }
   }