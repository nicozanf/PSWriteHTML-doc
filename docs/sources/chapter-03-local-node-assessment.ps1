Import-Module PSWriteHTML

# 1. Collect Infrastructure Data
$Services = Get-Service | Where-Object Status -eq 'Running' | Select-Object -First 5 -Property Name, DisplayName, Status
$Disks    = Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object DeviceID, @{N='Free Space (GB)'; E={[math]::Round($_.FreeSpace/1GB, 2)}}, @{N='Size (GB)'; E={[math]::Round($_.Size/1GB, 2)}}

# 2. Render Document Structure
New-HTML -Title "Local Node Assessment" -FilePath "$env:USERPROFILE\Desktop\LocalNode.html" -Show {

    New-HTMLTab -Name "System Status" {
        
        # Section 1: Running Services
        New-HTMLSection -HeaderText "Core Running Services" {
            New-HTMLPanel {
                New-HTMLTable -DataTable $Services
            }
        }

        # Section 2: Storage Allocation
        New-HTMLSection -HeaderText "Storage Overview" {
            New-HTMLPanel {
                New-HTMLTable -DataTable $Disks
            }
        }
    }
}
