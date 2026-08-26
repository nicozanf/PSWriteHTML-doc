
   # 1. Mock Health Check Data
   $Nodes  = Get-CimInstance Win32_OperatingSystem | Select-Object CSName, Caption, OSArchitecture, Version
   $Disks  = Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, @{N='FreeGB'; E={[math]::Round($_.FreeSpace/1GB, 2)}}

   # 2. Build Dashboard
   New-HTML -Title "Enterprise Health Monitor" -FilePath "$env:USERPROFILE\Desktop\HealthMonitor.html" -Show {

       # Tab 1: Executive Overview
       New-HTMLTab -Name "Overview" -IconSolid "chart-line" {
           
           # Top Row: Side-by-Side Cards
           New-HTMLSection -HeaderText "Environment Snapshot" {
               New-HTMLPanel {
                   New-HTMLTable -DataTable $Nodes -DisablePaging -DisableSearch
               }

               New-HTMLPanel {
                   New-HTMLTable -DataTable $Disks -DisablePaging -DisableSearch
               }
           }

           # Bottom Row: Collapsible Raw Logs
           New-HTMLSection -HeaderText "Raw WMI Event Logs" -CanCollapse -Collapsed {
               New-HTMLPanel {
                   New-HTMLText -Text "Verbose event trace logs captured during system boot sequence."
               }
           }
       }

       # Tab 2: Security & Compliance
       New-HTMLTab -Name "Compliance" -IconSolid "shield-alt" {
           New-HTMLSection -HeaderText "Audit Trail" {
               New-HTMLPanel {
                   New-HTMLText -Text "Status: OK. All local security policies match baseline standards."
               }
           }
       }
   }
